package malloc

class UserController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		[userList: User.list(params), userTotal: User.count()]
	}

	def create = {
		def user = new User()
		user.properties = params
		return [user: user]
	}

	def edit = {
		def user = User.get(params.id)
		if (!user) {
			flash.message = "${message(code: 'user.not.found.message', args: [params.id])}"
			redirect(action: "list")
		}
		else {
			render(view: 'create', model:[user: user])
		}
	}

	def save = {

		def user = User.get(params.id)
		def create = false
		if(user){
			if (params.version) {
				def version = params.version.toLong()
				if (user.version > version) {

					user.errors.rejectValue("version", "default.optimistic.locking.failure", [
						message(code: 'user.label', default: 'User')]
					as Object[], "Another user has updated this User while you were editing")
					render(view: "edit", model: [user: userInstance])
					return
				}
			}
			user.properties = params
		}else{
			user = new User(params)
			create = true
		}

		def file = request.getFile('photoFile')
		if(!file.empty) {
			// file.originalFilename
			file.transferTo( new File("${grailsApplication.config.upload.user.photo}${file.originalFilename}") )
			user.photoPath = file.originalFilename
		}

		if(!user.hasErrors() && user.save(flush: true)){
			if(create){
				flash.message = "${message(code: 'user.created.message', args: [user.name, user.surname])}"
			}else{
				flash.message = "${message(code: 'user.updated.message', args:[user.name, user.surname])}"
			}
			redirect(action:"show", params:["id":user.id])
		}else{
			render(view: 'create', model:[user:user])
		}
	}


	def show = {
		def user = User.get(params.id)
		if (!user) {
			flash.message = "${message(code: 'user.not.found.message', args: [params.id])}"
			redirect(action: "list")
		}
		else {
			[user: user]
		}
	}

	def delete = {
		def user = User.get(params.id)
		if (user) {
			try {
				user.delete(flush: true)
				flash.message = "${message(code: 'user.deleted.message', args: [user.name, user.surname])}"
				redirect(url: request.getHeader('referer'))
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'user.not.deleted.message', args: [user.name, user.surname])}"
				redirect(url: request.getHeader('referer'))
			}
		}
		else {
			flash.message = "${message(code: 'user.not.found.message', args: [params.id])}"
			redirect(url: request.getHeader('referer'))
		}
	}
}
