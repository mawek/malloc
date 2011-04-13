package malloc

import grails.test.*

class UserControllerIntegrationTests extends GroovyTestCase {

	User user
	UserController userController

	protected void setUp() {
		user = new User(name:"marek", surname:"gerhart", code:"MGe", email:"maweek@gmail.com")
		user.save()

		userController = new UserController()
	}

	protected void tearDown() {
		user.delete()
	}

	void testHandleLogin() {

		userController.params.code = user.code
		userController.request.setHeader("referer", "localhost")
		
		userController.handleLogin()

		assert session.user
		assertEquals user, session.user
	}

	void testLogout() {
		userController.session.user = user

		userController.logout()
		assertNull("No user after logout in the session", userController.session.user)
		assertEquals "/user/login", userController.response.redirectedUrl
	}
}
