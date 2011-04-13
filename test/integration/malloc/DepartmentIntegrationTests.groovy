package malloc

import grails.test.*

class DepartmentIntegrationTests extends GroovyTestCase {
	protected void setUp() {
		Department.list()*.delete()
	}



	void testPersist() {
		new Department(code:"apd", name:"application development", description:"apd desc").save()
		new Department(code:"had", name: "ha development", description:"").save()

		assert 2 == Department.count()
	}
}
