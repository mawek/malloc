package malloc

import org.joda.time.DateTime

import cz.mawek.grails.malloc.domainsupport.AllocationStatus
import cz.mawek.grails.malloc.domainsupport.AllocationType

class Allocation {

	static mapping = {
		columns {
			when column: 'requestDate'
			type column: 'typeAlloc'
		}
	}


	static constraints = {
		name(blank:false)
		type(nullable:false)
		requester(nullable:true)
		when(nullable:false)
		hours(size:3..3)

		worker(nullable:true)
		approver(nullable:true)
	}

	static hasMany = [discussion:Discussion]

	String name

	User worker
	User approver
	User requester

	String description
	String link
	AllocationType type
	AllocationStatus status
	DateTime when
	int hours
}
