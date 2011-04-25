package malloc

import org.joda.time.DateTime

import cz.mawek.grails.malloc.domainsupport.*

/*
 * findWhere,... http://bears-eat-beets.blogspot.com/2010/03/implementing-findwhere-and-findallwhere.html
 * criteria: http://grails.org/doc/latest/ref/Domain%20Classes/createCriteria.html
 * */
class AllocationController {

	static allowedMethods = [save: "POST", update: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {

		def filter = session.allocationListFilter
		if(!filter){
			filter = new HashMap()
			session.allocationListFilter = filter
		}
		filter.putAll(params)
		
		def offset = params.offset ? params.offset : 0
		
		
		def allocations = Allocation.withCriteria([sort:"startDate", order:"asc"]){
			and{
				if(filter['worker.id'] && !filter['worker.id'].equals('null')){
					eq("worker.id",new Long(filter['worker.id']))
				}
				if(filter['approver.id'] && !filter['approver.id'].equals('null')){
					eq("approver.id",new Long(filter['approver.id']))
				}
				if(filter['requester.id'] && !filter['requester.id'].equals('null')){
					eq("requester.id",new Long(filter['requester.id']))
				}
				if(filter['type'] && !filter['type'].equals('null')){
					eq("type",AllocationType.valueOf(filter['type']))
				}
				if(filter['status'] && !filter['status'].equals('null')){
					eq("status",AllocationStatus.valueOf(filter['status']))
				}
				if(filter['startDateSince_year']){
					def dts = new DateTime(new Integer(filter['startDateSince_year']),new Integer(filter['startDateSince_month']),new Integer(filter['startDateSince_day']),0,0,0,0)
					ge("startDate", dts)
					filter['startDateSince'] = dts
				}else{
					filter['startDateSince'] = null
				}
				if(filter['startDateTo_year']){
					def dtt = new DateTime(new Integer(filter['startDateTo_year']),new Integer(filter['startDateTo_month']),new Integer(filter['startDateTo_day']),23,59,59,0)
					le("startDate", dtt)
					filter['startDateTo'] = dtt
				}else{
					filter['startDateTo'] = null
				}
				maxResults(3)
				if(filter.offset){
					firstResult(filter.offset.toInteger())
				}
			}
		}


		[allocationList: allocations, allocationTotal:allocations.totalCount, filter:filter]
	}

	def my = {
		def user = User.get(params.userId)

		if(!user){
			// user musim nacitat vzdy odznova lebo to hodi drzku ked chcem lazy dotiahnut teamLeadera departmentu, ktory sa zistuje pri zakladani alokacie
			user = User.get(session.user?.id)
		}

		def myAllocations = {


			Allocation.createCriteria().list(sort:"startDate", order:"asc"){
				and{
					eq("worker",user)
					'in'("status",[
						AllocationStatus.GRANTED
					])
					ge("startDate", (new DateTime()).withTime(0, 0, 0, 0))
				}
			}
		}
		def myRequests = {
			Allocation.createCriteria().list{
				and{
					eq("requester",user)
					ge("startDate", (new DateTime()).withTime(0, 0, 0, 0))
				}
				order("startDate", "asc")
			}
		}
		def myApprovals = {
			Allocation.createCriteria().list{
				and{
					eq("approver",user)
					'in'("status",[
						AllocationStatus.NEW,
						AllocationStatus.CONSIDERING,
					])
					ge("startDate", (new DateTime()).withTime(0, 0, 0, 0))
				}
				order("startDate", "asc")
			}
		}


		//		render(view:"my", model:[myAllocations: Allocation.findAllWhere(["worker":session.user, "status":AllocationStatus.NEW])]) //funguje ale len na anditka
		render(view:"my", model:[myAllocations:myAllocations(), myRequests:myRequests(), myApprovals:myApprovals(), user:user]) //funguje
	}

	def create = {
		def allocation = new Allocation()
		allocation.properties = params
		return [allocation: allocation]
	}

	def save = {
		def allocation = Allocation.get(params.id)
		def created = false
		def oldAllocation = null
		if (allocation) {
			if (params.version) {
				def version = params.version.toLong()
				if (allocation.version > version) {

					allocation.errors.rejectValue("version", "default.optimistic.locking.failure", [
						message(code: 'allocation.label', default: 'Allocation')]
					as Object[], "Another user has updated this Allocation while you were editing")
					render(view: "create", model: [allocation: allocation])
					return
				}
			}
			oldAllocation = new Allocation(allocation.properties)
			allocation.properties = params
		}else{
			allocation = new Allocation(params)
			allocation.requester = session.user
			created = true
		}

		if (!allocation.hasErrors() && allocation.save(flush: true)) {
			if(created){
				sendMail {
					to allocation.requester?.email, allocation.worker?.email
					subject message(code: 'allocation.mail.create.subject')
					html g.render(template:"/email/allocation/create",model:[allocation: allocation])
				}
				flash.message = "${message(code: 'allocation.created.message')}"
			}else{
				sendMail {
					to allocation.requester?.email, allocation.worker?.email
					subject message(code: 'allocation.mail.update.subject')
					html g.render(template:"/email/allocation/update",model:[oldAllocation: oldAllocation, newAllocation: allocation])
				}
				flash.message = "${message(code: 'allocation.updated.message')}"
			}
			redirect(action: "show", id: allocation.id)
		}
		else {
			render(view: "create", model: [allocation: allocation])
		}
	}

	def approve = {
		def allocation = Allocation.get(params.id)
		if (!allocation) {
			flash.message = "${message(code: 'allocation.not.found.message', args: [params.id])}"
			redirect(url: request.getHeader('referer'))
		}
		else {
			allocation.status = AllocationStatus.GRANTED.name()

			sendMail {
				to allocation.requester?.email, allocation.worker?.email
				subject message(code: 'allocation.mail.approve.subject')
				html g.render(template:"/email/allocation/approve",model:[allocation: allocation])
			}

			flash.message = "${message(code: 'allocation.approved.message')}"
			redirect(url: request.getHeader('referer'))
		}
	}

	def refuse = {
		def allocation = Allocation.get(params.id)
		if (!allocation) {
			flash.message = "${message(code: 'allocation.not.found.message', args: [params.id])}"
			redirect(url: request.getHeader('referer'))
		}
		else {
			allocation.status = AllocationStatus.REFUSED.name()

			sendMail {
				to allocation.requester.email
				subject message(code: 'allocation.mail.refuse.subject')
				html g.render(template:"/email/allocation/refuse",model:[allocation: allocation])
			}

			flash.message = "${message(code: 'allocation.refused.message')}"
			redirect(url: request.getHeader('referer'))
		}
	}

	def show = {
		def allocation = Allocation.get(params.id)
		if (!allocation) {
			flash.message = "${message(code: 'allocation.not.found.message', args: [params.id])}"
			redirect(action: "list")
		}
		else {
			[allocation: allocation]
		}
	}

	def edit = {
		def allocation = Allocation.get(params.id)
		if (!allocation) {
			flash.message = "${message(code: 'allocation.not.found.message', args: [params.id])}"
			redirect(action: "list")
		}
		else {
			render(view: "create", model: [allocation: allocation])
		}
	}

	def delete = {
		def allocation = Allocation.get(params.id)
		if (allocation) {
			try {
				allocation.delete(flush: false)

				// mail posielam requesterovi ak mu zmaze alokaciu niekto iny ako on sam
				if(session.user.id != allocation.requester?.id){
					sendMail {
						to allocation.requester.email
						subject message(code: 'allocation.mail.delete.subject')
						html g.render(template:"/email/allocation/delete",model:[allocation: allocation])
					}
				}

				flash.message = "${message(code: 'allocation.deleted.message')}"
				redirect(url: request.getHeader('referer'))
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'allocation.not.deleted.message')}"
				redirect(url: request.getHeader('referer'))
			}
		}
		else {
			flash.message = "${message(code: 'allocation.not.found.message', args: [params.id])}"
			redirect(url: request.getHeader('referer'))
		}
	}
}