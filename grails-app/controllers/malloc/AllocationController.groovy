package malloc

import org.joda.time.DateTime

import cz.mawek.grails.malloc.domainsupport.AllocationStatus

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
		params.max = Math.min(params.max ? params.int('max') : 50, 100)
		[allocationList: Allocation.list(params), allocationTotal: Allocation.count()]
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
					render(view: "edit", model: [allocation: allocation])
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
				subject message(code: 'allocation.mailer.approve.subject')
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
				subject message(code: 'allocation.mailer.refuse.subject')
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
						subject message(code: 'allocation.mailer.delete.subject')
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
