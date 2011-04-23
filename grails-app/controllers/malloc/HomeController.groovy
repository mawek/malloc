package malloc

class HomeController {

	def index = {
		if(session.user){
			redirect(controller:"allocation", action:"my")
		}
	}
}
