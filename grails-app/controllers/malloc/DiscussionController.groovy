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
		def discussion = new Discussion(params)
		discussion.user = session.user
		discussion.date = new DateTime()

		if (discussion.save(flush: true)) {
			sendMail {
				to discussion.allocation.worker?.email, discussion.allocation.requester?.email, discussion.allocation.approver?.email
				subject message(code: 'discussion.mail.create.subject')
				html g.render(template:"/email/discussion/create",model:[discussion: discussion])
			}
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
				def allocation = discussion.allocation
				def userId = discussion.user.id
				discussion.delete(flush: true)

				if(session.user.id != userId){
					sendMail {
						to discussion.user?.email
						subject message(code: 'discussion.mail.create.subject')
						html g.render(template:"/email/discussion/delete",model:[discussion: discussion, allocation:allocation])
					}
				}

				return render(template: "show", var:'discussion', collection: Allocation.get(params.allocationId).discussion)
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				//				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'discussion.label', default: 'Discussion'), params.id])}"
				return render(template: "show", var:'discussion', collection: Allocation.get(params.allocationId).discussion)
			}
		}

		render(template: "show", var:'discussion', collection: Allocation.get(params.allocationId).discussion)
	}
}
