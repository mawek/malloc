package malloc

import org.joda.time.DateTime

import cz.mawek.grails.malloc.domainsupport.AllocationStatus

/*
 * findWhere,... http://bears-eat-beets.blogspot.com/2010/03/implementing-findwhere-and-findallwhere.html
 * criteria: http://grails.org/doc/latest/ref/Domain%20Classes/createCriteria.html
 * */
class AllocationController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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
			user = session.user
		}	

		def myAllocations = {
			
			
			Allocation.createCriteria().list(sort:"startDate", order:"asc"){
				and{
					eq("worker",user)
					'in'("status",[
						AllocationStatus.NEW,
						AllocationStatus.SPECIFY_REQUEST
					])
					ge("startDate", (new DateTime()).withTime(0, 0, 0, 0))
				}
			}
		}
		def myRequests = {
			Allocation.createCriteria().list{
				and{
					eq("requester",user)
					'in'("status",[
						AllocationStatus.NEW,
						AllocationStatus.SPECIFY_REQUEST
					])
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
						AllocationStatus.SPECIFY_REQUEST
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
			allocation.properties = params
		}else{
			allocation = new Allocation(params)
			allocation.requester = session.user
			created = true
		}

		if (!allocation.hasErrors() && allocation.save(flush: true)) {
			if(created){
				sendMail {
					to allocation.requester?.email
					subject "Hello to mutliple recipients"
					body "Hello Fred! Hello Ginger!"
				}
				flash.message = "${message(code: 'allocation.created.message')}"
			}else{
				flash.message = "${message(code: 'allocation.updated.message')}"
			}
			redirect(action: "show", id: allocation.id)
		}
		else {
			render(view: "create", model: [allocation: allocation])
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
		//TODO: posli mail ak si requester ale alokaciu ti zmazal niekto iny
		def allocationInstance = Allocation.get(params.id)
		if (allocationInstance) {
			try {
				allocationInstance.delete(flush: true)
				flash.message = "${message(code: 'allocation.deleted.message')}"
				redirect(url: request.getHeader('referer'))
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'allocation.not.deleted.message')}"
//				redirect(action: "show", id: params.id)
				redirect(url: request.getHeader('referer'))
			}
		}
		else {
			flash.message = "${message(code: 'allocation.not.found.message', args: [params.id])}"
//			redirect(action: "list")
			redirect(url: request.getHeader('referer'))
		}
	}
}
