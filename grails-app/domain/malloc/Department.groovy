package malloc

class Department {

	static constraints = {
		name(blank:false)
		description(blank:true)
		teamLeader(nullable:true)
	}

	String name
	String description
	User teamLeader
	static hasMany = [members:User]	
}
