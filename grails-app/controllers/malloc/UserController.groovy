package malloc

class UserController {

	def scaffold = User

	def handleLogin = {
		def user = User.findByCode(params.code)
		if(!user){
			flash.message = "User for code '${params.code}' not found."
			return
		}

		session.user = user
		redirect(controller: 'user')
	}

	def logout = {
		session.user = null
		redirect(controller: 'user')
	}
}
