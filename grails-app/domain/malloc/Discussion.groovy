package malloc

import org.joda.time.DateTime

import cz.mawek.grails.malloc.domainsupport.AllocationStatus

class Discussion {

	static mapping = {
		columns { date column: 'insertDate'			 }
	}

	static constraints = {
		note(blank:false)
		user(nullable:false)
		allocatioNStatus(nullable:true)
	}

	static belongsTo = Allocation
	static hasMany = [discussion:Discussion]
	Discussion parent

	String note
	String user
	DateTime date
	AllocationStatus allocationStatus
	Allocation allocation
}
