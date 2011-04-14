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

		def myAllocations = {
			Allocation.createCriteria().list(sort:"when", order:"asc"){
				and{
					eq("worker",session.user)
					'in'("status",[
						AllocationStatus.NEW,
						AllocationStatus.SPECIFY_REQUEST
					])
					gt("when", new DateTime())
				}
			}
		}
		def myRequests = {
			Allocation.createCriteria().list{
				and{
					eq("requester",session.user)
					'in'("status",[
						AllocationStatus.NEW,
						AllocationStatus.SPECIFY_REQUEST
					])
					gt("when", new DateTime())
				}
				order("when", "asc")
			}
		}
		def myApprovals = {
			Allocation.createCriteria().list{
				and{
					eq("approver",session.user)
					'in'("status",[
						AllocationStatus.NEW,
						AllocationStatus.SPECIFY_REQUEST
					])
					gt("when", new DateTime())
				}
				order("when", "asc")
			}
		}


		//		render(view:"my", model:[myAllocations: Allocation.findAllWhere(["worker":session.user, "status":AllocationStatus.NEW])]) //funguje ale len na anditka
		render(view:"my", model:[myAllocations:myAllocations(), myRequests:myRequests(), myApprovals:myApprovals()]) //funguje
	}

	def create = {
		def allocation = new Allocation()
		allocation.properties = params
		return [allocation: allocation]
	}

	def save = {
		def allocation = Allocation.get(params.id)
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
		}else{
			allocation = new Allocation(params)
			allocation.requester = session.user
		}

		if (!allocation.hasErrors() && allocation.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'allocation.label', default: 'Allocation'), allocation.id])}"
			redirect(action: "show", id: allocation.id)
		}
		else {
			render(view: "create", model: [allocation: allocation])
		}
	}

	def show = {
		def allocation = Allocation.get(params.id)
		if (!allocation) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'allocation.label', default: 'Allocation'), params.id])}"
			redirect(action: "list")
		}
		else {
			[allocation: allocation]
		}
	}

	def edit = {
		def allocation = Allocation.get(params.id)
		if (!allocation) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'allocation.label', default: 'Allocation'), params.id])}"
			redirect(action: "list")
		}
		else {
			render(view: "create", model: [allocation: allocation])
		}
	}

	def delete = {
		def allocationInstance = Allocation.get(params.id)
		if (allocationInstance) {
			try {
				allocationInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'allocation.label', default: 'Allocation'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'allocation.label', default: 'Allocation'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'allocation.label', default: 'Allocation'), params.id])}"
			redirect(action: "list")
		}
	}
}
