package malloc

/*
 * multicheckbox: http://stackoverflow.com/questions/2806101/grails-simple-hasmany-problem-using-checkboxes-rather-than-html-select-in-cre
 * */
class DepartmentController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[departmentInstanceList: Department.list(params), departmentInstanceTotal: Department.count()]
	}

	def create = {
		def department = new Department()
		department.properties = params
		return [department: department]
	}

	def save = {
		def department = Department.get(params.id)
		if (department) {
			if (params.version) {
				def version = params.version.toLong()
				if (department.version > version) {

					department.errors.rejectValue("version", "default.optimistic.locking.failure", [
						message(code: 'department.label', default: 'Department')]
					as Object[], "Another user has updated this Department while you were editing")
					render(view: "edit", model: [department: department])
					return
				}
			}
			department.properties = params
		}else{
			department = new Department(params)
		}

		if (!department.hasErrors() && department.save(flush: true)) {
			department.members.each{ it.department = null }
			department?.members.clear()
			params.each {
				if (it.key.startsWith("member")){
					User.get((it.value) as Integer).department = department
				}
			}

			flash.message = "${message(code: 'default.created.message', args: [message(code: 'department.label', default: 'Department'), department.id])}"
			redirect(action: "show", id: department.id)
		} else {
			render(view: "create", model: [department: department])
		}
	}

	def show = {
		def departmentInstance = Department.get(params.id)
		if (!departmentInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
			redirect(action: "list")
		}
		else {
			[departmentInstance: departmentInstance]
		}
	}

	def edit = {
		def departmentInstance = Department.get(params.id)
		if (!departmentInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
			redirect(action: "list")
		}
		else {
			render(view: 'create', model:[department: departmentInstance])
		}
	}



	def delete = {
		def departmentInstance = Department.get(params.id)
		if (departmentInstance) {
			try {
				departmentInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
			redirect(action: "list")
		}
	}
}
