

<%@ page import="malloc.Department" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'department.label', default: 'Department')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${department}">
            <div class="errors">
                <g:renderErrors bean="${department}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            	<g:hiddenField name="id" value="${department?.id}" />
                <g:hiddenField name="version" value="${department?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="code"><g:message code="department.code.label" default="Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: department, field: 'code', 'errors')}">
                                    <g:textField name="code" value="${department?.code}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="department.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: department, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${department?.name}" />
                                </td>
                            </tr>    
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="department.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: department, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${department?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="teamLeader"><g:message code="department.teamLeader.label" default="Team Leader" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: department, field: 'teamLeader', 'errors')}">
                                    <g:select name="teamLeader.id" from="${malloc.User.list()}" optionKey="id" value="${department?.teamLeader?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                            
	                        <!--  -->
	
							<tr class="prop">
								<td valign="top" class="name"><label for="members"><g:message code="department.members.label" default="Members" />
								</label></td>
								<td valign="top" class="value ${hasErrors(bean: department, field: 'members', 'errors')}">
									<g:each in="${malloc.User.list()}" status="i" var="user">										
										<g:checkBox name="member[${user.id}]" value="${user.id}" checked="${department?.members?.contains(user)}" />&nbsp;${user.code}&nbsp;-&nbsp;${user.name}&nbsp;${user.surname}</br>
									</g:each></td>
							</tr>
	
	
							<!--  -->
                            
                            <!-- 
                            <tr class="prop">
							<td valign="top" class="name"><label for="members"><g:message code="department.members.label" default="Members" />
							</label></td>
							<td valign="top" class="value ${hasErrors(bean: department, field: 'members', 'errors')}">
								<ul>
									<g:each in="${department?.members?}" var="m">
										<li><g:link controller="user" action="show" id="${m.id}">
												${m?.encodeAsHTML()}
											</g:link>
										</li>
									</g:each>
								</ul> <g:link controller="user" action="create" params="['department.id': department?.id]">
									${message(code: 'default.add.label', args: [message(code: 'user.label', default: 'User')])}
								</g:link></td>
						</tr>
						 -->
                            
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
