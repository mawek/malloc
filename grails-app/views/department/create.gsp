<%@ page import="malloc.Department"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>
	<g:if test="${department?.id}">
		<g:message code="department.edit.label" />
	</g:if> <g:else>
		<g:message code="department.create.label" />
	</g:else>
</title>
</head>
<body>
	
	<div class="body">
		<h1>
			<g:if test="${user?.id}">
				<g:message code="department.edit.label" />
			</g:if>
			<g:else>
				<g:message code="department.create.label" />
			</g:else>
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${department}">
			<div class="errors">
				<g:renderErrors bean="${department}" as="list" />
			</div>
		</g:hasErrors>
		<g:form action="save">
			<g:hiddenField name="id" value="${department?.id}" />
			<g:hiddenField name="version" value="${department?.version}" />
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name"><label for="code"><g:message code="department.code.label" default="Code" />
							</label></td>
							<td valign="top" class="value ${hasErrors(bean: department, field: 'code', 'errors')}"><g:textField name="code"
									value="${department?.code}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="name"><g:message code="department.name.label" default="Name" />
							</label></td>
							<td valign="top" class="value ${hasErrors(bean: department, field: 'name', 'errors')}"><g:textField name="name"
									value="${department?.name}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="description"><g:message code="department.description.label"
										default="Description" />
							</label></td>
							<td valign="top" class="value ${hasErrors(bean: department, field: 'description', 'errors')}">
							<g:textField name="description"	value="${department?.description}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="teamLeader"><g:message code="department.teamLeader.label"
										default="Team Leader" />
							</label></td>
							<td valign="top" class="value ${hasErrors(bean: department, field: 'teamLeader', 'errors')}"><g:select name="teamLeader.id"
									from="${malloc.User.list()}" optionKey="id" value="${department?.teamLeader?.id}" noSelection="['null': '']" /></td>
						</tr>						

						<tr class="prop">
							<td valign="top" class="name"><label for="members"><g:message code="department.members.label" default="Members" /> </label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: department, field: 'members', 'errors')}">
								
								<div style="overflow-y:scroll; height:200px; border:1px solid; padding:5px;">
								
								<g:each in="${malloc.User.list()}" status="i" var="user">
									<g:checkBox name="member[${user.id}]" value="${user.id}" checked="${department?.members?.contains(user)}" />&nbsp;${user.code}&nbsp;-&nbsp;${user.name}&nbsp;${user.surname}</br>
								</g:each>
								
								</div>
							</td>
						</tr>

					</tbody>
				</table>
			</div>
			<div class="buttons">				
				<span class="button"> <g:if test="${department?.id}">
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
