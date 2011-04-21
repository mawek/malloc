<%@ page import="malloc.User"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>
	<g:if test="${user?.id}">
		<g:message code="user.edit.label" />
	</g:if> <g:else>
		<g:message code="user.create.label" />
	</g:else></title>
</head>
<body>
	<div class="body">
		<h1>
			<g:if test="${user?.id}">
				<g:message code="user.edit.label" />
			</g:if>
			<g:else>
				<g:message code="user.create.label" />
			</g:else>
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${user}">
			<div class="errors">
				<g:renderErrors bean="${user}" as="list" />
			</div>
		</g:hasErrors>
		<g:form action="save" enctype="multipart/form-data">
			<g:hiddenField name="id" value="${user?.id}" />
			<g:hiddenField name="version" value="${user?.version}" />
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name"><label for="code"><g:message code="user.code.label" default="Code" /> </label></td>
							<td valign="top" class="value ${hasErrors(bean: user, field: 'code', 'errors')}"><g:textField name="code" maxlength="3"
									value="${user?.code}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="name"><g:message code="user.name.label" default="Name" /> </label></td>
							<td valign="top" class="value ${hasErrors(bean: user, field: 'name', 'errors')}"><g:textField name="name" value="${user?.name}" />
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="surname"><g:message code="user.surname.label" default="Surname" /> </label></td>
							<td valign="top" class="value ${hasErrors(bean: user, field: 'surname', 'errors')}"><g:textField name="surname"
									value="${user?.surname}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="email"><g:message code="user.email.label" default="Email" /> </label></td>
							<td valign="top" class="value ${hasErrors(bean: user, field: 'email', 'errors')}"><g:textField name="email"
									value="${user?.email}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="department"><g:message code="user.department.label" default="Department" /> </label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: user, field: 'department', 'errors')}"><g:select name="department.id"
									from="${malloc.Department.list()}" optionKey="id" value="${user?.department?.id}" optionValue="code" noSelection="['null': '']" /></td>
						</tr>


						<tr class='prop'>
							<td valign='top' class='name'><label for='photoFile'><g:message code="user.photo.label" default="Photo" /> </label></td>
							<td valign='top' class='value ${hasErrors(bean:user,field:'photoPath','errors')}'><input type="file" name="photoFile" /></td>
						</tr>

					</tbody>
				</table>
				
				<!-- 
				<div>
					<img alt="${user.code}" src="file:///${grailsApplication.config.upload.user.photo}${user.photoPath}">					
				</div>
				 -->
			</div>
			<div class="buttons">
				<span class="button"> <g:if test="${user?.id}">
						<g:submitButton name="create" class="save" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
					</g:if> <g:else>
						<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</g:else> </span>
			</div>
		</g:form>
	</div>
</body>
</html>
