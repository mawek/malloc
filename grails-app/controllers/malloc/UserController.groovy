package malloc

class UserController {

	def scaffold = User

	def login = {
	}

	def handleLogin = {
		def user = User.findByCode(params.code)
		if(!user){
			flash.message = "User for code '${params.code}' not found."
			redirect(action: 'login')
		}

		session.user = user
		redirect(controller: 'user')
	}

	def logout = {
		session.user = null
		redirect(action: 'login')
	}
}
