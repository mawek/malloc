package malloc

import cz.mawek.grails.malloc.domainsupport.AllocationType

class Allocation {

	static constraints = {
	}

	String name

	User worker
	User approver
	User requester

	String description
	String link
	AllocationType typee
}
