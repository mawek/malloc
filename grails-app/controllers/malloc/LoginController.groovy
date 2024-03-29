package malloc

class LoginController {

	static allowedMethods = [login: "POST"]

	def login = {
		if(!params.code){
			return redirect(controller: 'home')
		}
		
		def user = User.findByCode(params.code)
		if(!user){
			flash.message = "User for code '${params.code}' not found."			
		}

		session.user = user		
		redirect(url: request.getHeader('referer'))
	}

	def logout = {
		session.user = null
		redirect(controller: 'home')
	}
}
