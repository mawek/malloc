package malloc

import org.joda.time.DateTime

class DiscussionController {

	static allowedMethods = [save: "POST"]

	def list = {
		if(!params.allocationId){
			return [discussion:[]]
		}

		[discussion: Discussion.findByAllocationId(params.allocationId)]
	}

	def save = {
		def discussion = new Discussion(params.discussionId)
		discussion.user = session.user
		discussion.date = new DateTime()

		if (discussion.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'discussion.label', default: 'Discussion'), discussion.id])}"
			render(template: "show", var:'discussion', collection: Allocation.get(params['allocation.id']).discussion)
		}
		else {
			render(template: "show", var:'discussion', collection: Allocation.get(params['allocation.id']).discussion)
		}
	}


	def delete = {
		def discussion = Discussion.get(params.id)		
		if (discussion) {
			try {
				discussion.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'discussion.label', default: 'Discussion'), params.id])}"
				return render(template: "show", var:'discussion', collection: Allocation.get(params.allocationId).discussion)
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'discussion.label', default: 'Discussion'), params.id])}"
				return render(template: "show", var:'discussion', collection: Allocation.get(params.allocationId).discussion)
			}
		}
		
		render(template: "show", var:'discussion', collection: Allocation.get(params.allocationId).discussion)
	}
}
