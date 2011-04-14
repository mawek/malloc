<%@ page import="malloc.Department"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>
	<g:message code="department.detail.label" />
</title>
</head>
<body>	
	<div class="body">
		<h1>
			<g:message code="department.detail.label" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="dialog">
			<table>
				<tbody>
					<tr class="prop">
						<td valign="top" class="name"><g:message code="department.code.label" default="Code" />
						</td>

						<td valign="top" class="value">
							${fieldValue(bean: department, field: "code")}
						</td>

					</tr>					

					<tr class="prop">
						<td valign="top" class="name"><g:message code="department.name.label" default="Name" />
						</td>

						<td valign="top" class="value">
							${fieldValue(bean: department, field: "name")}
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><g:message code="department.description.label" default="Description" />
						</td>

						<td valign="top" class="value">
							${fieldValue(bean: department, field: "description")}
						</td>

					</tr>

					<tr class="prop">
						<td valign="top" class="name"><g:message code="department.teamLeader.label" default="Team Leader" />
						</td>

						<td valign="top" class="value"><g:link controller="user" action="show" id="${department?.teamLeader?.id}">
								${department?.teamLeader?.encodeAsHTML()}
							</g:link>
						</td>

					</tr>

					<tr class="prop">
						<td valign="top" class="name"><g:message code="department.members.label" default="Members" />
						</td>

						<td valign="top" style="text-align: left;" class="value">
							<ul>
								<g:each in="${department.members}" var="m">
									<li><g:link controller="user" action="show" id="${m.id}">
											${m?.encodeAsHTML()}
										</g:link>
									</li>
								</g:each>
							</ul></td>

					</tr>

				</tbody>
			</table>
		</div>
		<div class="buttons">
			<g:form>
				<g:hiddenField name="id" value="${department?.id}" />
				<span class="button"><g:actionSubmit class="edit" action="edit"
						value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
				</span>
				<span class="button"><g:actionSubmit class="delete" action="delete"
						value="${message(code: 'default.button.delete.label', default: 'Delete')}"
						onclick="return confirm('${message(code: 'department.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</span>
			</g:form>
		</div>
	</div>
</body>
</html>
