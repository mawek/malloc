package malloc

import org.joda.time.DateTime

import cz.mawek.grails.malloc.domainsupport.AllocationStatus

class Discussion {

	static mapping = {
		columns { date column: 'insertDate'}
		note type: 'text'
	}

	static constraints = {
		note(blank:false)
		user(nullable:false)
				
	}

	static belongsTo = Allocation

	String note
	User user
	DateTime date	
	Allocation allocation
}
