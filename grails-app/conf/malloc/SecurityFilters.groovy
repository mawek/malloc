package malloc

class SecurityFilters {
	def filters = {
		loginFilter(controller:'*', action : '*'){
			before = {
				if(!session.user && (!controllerName.equals('login') && !controllerName.equals('home'))){
					redirect(controller:'home')
					return false
				}
			}
		}
	}
}
