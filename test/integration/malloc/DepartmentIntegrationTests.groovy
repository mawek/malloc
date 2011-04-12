package malloc

import grails.test.*

class DepartmentIntegrationTests extends GroovyTestCase {
	protected void setUp() {
		Department.list()*.delete()
	}



	void testPersist() {
		new Department(name:"apd", description:"apd desc").save()
		new Department(name:"had", description:"had desc").save()

		assert 2 == Department.count()
	}
}
