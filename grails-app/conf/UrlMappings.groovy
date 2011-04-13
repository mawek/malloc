/*
 * Default controller: http://stackoverflow.com/questions/198936/best-practices-for-grails-index-page
 * */
class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"{
			controller = "home"
		}
		
		"500"(view:'/error')
	}
}
