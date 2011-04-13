package malloc

import grails.test.*

class UserIntegrationTests extends GroovyTestCase {
	protected void setUp() {
		User.list()*.delete()
	}
	
	protected void tearDown() {
		User.list()*.delete()
	}

	void testPersist() {
		new User(name:"marek", surname:"gerhart", code:"MGe", email:"maweek@gmail.com").save()
		new User(name:"puk", surname:"puknuty", code:"PUk", email:"puko@gmail.com").save()
		new User(name:"prdik", surname:"vyprdkany", code:"PVy", email:"prdko@gmail.com").save()

		assert 3 == User.count()

		def mawekUser = User.findByCode("MGe")
		assert mawekUser
		assert "maweek@gmail.com" == mawekUser.email
	}
}
