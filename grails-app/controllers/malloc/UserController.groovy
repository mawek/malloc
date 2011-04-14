package malloc

class UserController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}

	def handleLogin = {
		def user = User.findByCode(params.code)
		if(!user){
			flash.message = "User for code '${params.code}' not found."
			return
		}

		session.user = user
		redirect(url: request.getHeader('referer'))
	}

	def logout = {
		session.user = null
		redirect(controller: 'home')
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
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
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
		def userInstance = User.get(params.id)
		if (!userInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
			redirect(action: "list")
		}
		else {
			[userInstance: userInstance]
		}
	}

	def delete = {
		def userInstance = User.get(params.id)
		if (userInstance) {
			try {
				userInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
			redirect(action: "list")
		}
	}
}
