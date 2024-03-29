<%@ page import="malloc.Allocation"%>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />

	<!-- popis v liste vytvorenia/zalozenia alokacie -->
	<title>
		<g:if test="${allocation?.id}">
			<g:message code="allocation.edit.label" />
		</g:if> <g:else>
			<g:message code="allocation.create.label" />
		</g:else>
	</title>
</head>
<body>


	<calendar:resources lang="en" theme="tiger" />
	<div class="body">
	
		<!-- nadpis vytvorenia/editacie alokacie -->
		<h1>
			<g:if test="${allocation?.id}">
				<g:message code="allocation.edit.label" />
			</g:if>
			<g:else>
				<g:message code="allocation.create.label" />
			</g:else>
		</h1>
		
		<!-- zobrazenie flash sprav -->
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		
		
		<!-- zobrazenie chybovych hlasiek -->
		<g:hasErrors bean="${allocation}">
			<div class="errors">
				<g:renderErrors bean="${allocation}" as="list" />
			</div>
		</g:hasErrors>
		
		
		<!-- forumar na vytvorenie/editaciu alokacie -->
		<g:form action="save">
			<g:hiddenField name="id" value="${allocation?.id}" />
			<g:hiddenField name="version" value="${allocation?.version}" />
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="name">
									<g:message code="allocation.name.label" default="Name" /> 
								</label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'name', 'errors')}">
								<g:textField name="name" size="23" value="${allocation?.name}" />
							</td>
							
							<td valign="top" class="name">
								<label for="startDate">
									<g:message code="allocation.startDate.label" default="Start date" />
								</label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'startDate', 'errors')}">
								<calendar:datePicker name="startDate" value="${allocation.startDate?.toDate()}" dateFormat="%d.%m.%Y" defaultValue="${new Date()}" />
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="status">
									<g:message code="allocation.status.label" default="Status" /> 
								</label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'status', 'errors')}">							
								<g:select name="status" style="width:80%;" keys="${cz.mawek.grails.malloc.domainsupport.AllocationStatus?.values()}" from="${cz.mawek.grails.malloc.domainsupport.AllocationStatus.values().collect{message(code: 'allocation.status.'+it.name())}}" value="${allocation.status?.name()}" />
							</td>
							
							<td valign="top" class="name">
								<label for="endDate">
									<g:message code="allocation.endDate.label" default="End date" /> 
								</label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'endDate', 'errors')}">
								<calendar:datePicker name="endDate" value="${allocation.endDate?.toDate()}" dateFormat="%d.%m.%Y" defaultValue="${new Date()}" />
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="type">
									<g:message code="allocation.type.label" default="Type" /> 
								</label>							
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'type', 'errors')}">
								<g:select name="type" style="width:80%;" keys="${cz.mawek.grails.malloc.domainsupport.AllocationType?.values()}" from="${cz.mawek.grails.malloc.domainsupport.AllocationType.values().collect{message(code: 'allocation.type.'+it.name())}}"  value="${allocation.type?.name()}" />
							</td>
							
							<td valign="top" class="name">
								<label for="link">
									<g:message code="allocation.link.label" default="Link" /> 
								</label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'link', 'errors')}">
								<g:textField name="link" value="${allocation?.link}" />
							</td>
						</tr>
						

						<tr class="prop">
							<td valign="top" class="name">
								<label for="worker">
									<g:message code="allocation.worker.label" default="Worker" /> 
								</label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'worker', 'errors')}">
								<g:select name="worker.id" style="width:80%;" from="${malloc.User.list()}" optionKey="id" value="${allocation?.worker?.id}" noSelection="['null': '']" />
							</td>
							
							<td valign="top" class="name">
								<label for="approver">
									<g:message code="allocation.approver.label" default="Approver" /> 
								</label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'approver', 'errors')}">
								<g:select name="approver.id" from="${malloc.User.list()}" optionKey="id" value="${allocation?.approver?.id}" noSelection="['null': '']" />
							</td>
						</tr>						

						<tr class="prop">
							<td valign="top" class="name">
								<label for="hours">
									<g:message code="allocation.hours.label" default="Hours" /> 
								</label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'hours', 'errors')}">
								<g:select name="hours" style="width:80%;" from="${1..40}" value="${fieldValue(bean: allocation, field: 'hours')}"/>	
							</td>
						
							<td valign="top" class="name">
								<label for="description">
									<g:message code="allocation.description.label" default="Description" /> </label>
							</td>
							
							<td valign="top" class="value ${hasErrors(bean: allocation, field: 'description', 'errors')}">
								<g:textArea name="description" value="${allocation?.description}" />
							</td>
						</tr>

					</tbody>
				</table>
			</div>
			
			<!-- button na potvrdenie editacie/vytvorenia uzivatela -->
			<div class="buttons">
				<span class="button"> <g:if test="${allocation?.id}">
						<g:submitButton name="create" class="save" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
					</g:if> <g:else>
						<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</g:else> 
				</span>
			</div>
		</g:form>
	</div>
</body>
</html>
