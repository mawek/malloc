package malloc

/**
 * Redirec naspet po logine: http://stackoverflow.com/questions/1451314/how-to-redirect-to-the-last-visited-page-in-grails-app
 * */
class UserController {

	def scaffold = User

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
}
