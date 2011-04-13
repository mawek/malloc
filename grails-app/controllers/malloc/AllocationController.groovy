package malloc

class AllocationController {

	def scaffold = Allocation
	
	def save = {
		
		def allocation = new Allocation(params)
		allocation.requester = session.user
		allocation.save()

		redirect(action:"show", params:["id":allocation.id])
	}
}
