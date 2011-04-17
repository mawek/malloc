package malloc

import org.joda.time.DateTime

import cz.mawek.grails.malloc.domainsupport.AllocationStatus
import cz.mawek.grails.malloc.domainsupport.AllocationType

class Allocation {

	static mapping = {
		columns {
			date column: 'requestDate'
			type column: 'typeAlloc'
		}
		discussion sort:'date', order:'desc'
	}


	static constraints = {
		name(blank:false)
		type(nullable:false)
		requester(nullable:true)
		date(nullable:false)
		hours(blank:false, min:1, max:8)
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
	DateTime date
	int hours
}
