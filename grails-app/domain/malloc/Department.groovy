package malloc

class Department {

	static constraints = {
		name(blank:false,unique:true)
		description(blank:true)
		teamLeader(nullable:true)
	}

	String name
	String description
	User teamLeader
	static hasMany = [members:User]
}
