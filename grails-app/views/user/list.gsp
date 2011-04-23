<%@ page import="malloc.User"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title><g:message code="user.list.label" />
</title>
</head>
<body>
	<div class="nav">
		<span class="menuButton"><g:link class="create" action="create">
				<g:message code="user.new.label" />
			</g:link> </span>
	</div>
	<div class="body">
		<h1>
			<g:message code="user.list.label" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="list">
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="code" title="${message(code: 'user.code.label', default: 'Code')}" />

						<g:sortableColumn property="name" title="${message(code: 'user.name.label', default: 'Name')}" />

						<g:sortableColumn property="surname" title="${message(code: 'user.surname.label', default: 'Surname')}" />

						<g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}" />

						<th><g:message code="user.department.label" default="Department" />	</th>
						<th></th>

					</tr>
				</thead>
				<tbody>
					<g:each in="${userList}" status="i" var="user">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

							<td><g:link action="show" id="${user.id}">
									${fieldValue(bean: user, field: "code")}
								</g:link>
							</td>

							<td>
								${fieldValue(bean: user, field: "name")}
							</td>

							<td>
								${fieldValue(bean: user, field: "surname")}
							</td>

							<td><a href="mailto:${fieldValue(bean: user, field: "email")}"> ${fieldValue(bean: user, field: "email")} </a>
							</td>

							<td nowrap="nowrap">
								<g:link action="show" controller="department" id="${user.department?.id}">
									<g:shortly value='${fieldValue(bean: user, field: "department")}'/>									
								</g:link>																
							</td>
							<td width="10%">								
								<g:form>
                    				<g:hiddenField name="id" value="${user?.id}" />
                    				<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    				<br/>
                    				<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'user.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                				</g:form>                				
							</td>

						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
		<div class="paginateButtons">
			<g:paginate total="${userTotal}" />
		</div>
	</div>

	<br />
	<div class="nav">
		<span class="menuButton"><g:link class="create" action="create">
				<g:message code="user.new.label" />
			</g:link> </span>
	</div>
</body>
</html>
