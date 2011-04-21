package malloc

import org.joda.time.DateTime

import cz.mawek.grails.malloc.domainsupport.AllocationStatus
import cz.mawek.grails.malloc.domainsupport.AllocationType

class Allocation {

	static mapping = {
		columns {
			startDate column: 'startDate'
			endDate column: 'endDate'
			type column: 'typeAlloc'
		}
		discussion sort:'date', order:'desc'
	}


	static constraints = {
		name(blank:false)
		type(nullable:false)
		requester(nullable:true)
		startDate(nullable:false)
		endDate(nullable:true,
				validator: {val, obj ->
					if (val?.compareTo(obj.startDate) >= 0 ) {
						return true
					}
					return true
				})
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
	DateTime startDate
	DateTime endDate
	int hours
}
