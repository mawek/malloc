package malloc

class Department {

	static constraints = {
		code(blank:false,unique:true)
		name(blank:false)
		description(blank:true)
		teamLeader(nullable:true)
	}

	String code
	String name
	String description
	User teamLeader
	static hasMany = [members:User]

	@Override
	public String toString(){
		"$code - $name"
	}
}
