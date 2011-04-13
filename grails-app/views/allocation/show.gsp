
<%@ page import="malloc.Allocation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'allocation.label', default: 'Allocation')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocationInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocationInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${allocationInstance?.type?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.requester.label" default="Requester" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${allocationInstance?.requester?.id}">${allocationInstance?.requester?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.when.label" default="When" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocationInstance, field: "when")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.hours.label" default="Hours" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocationInstance, field: "hours")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.worker.label" default="Worker" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${allocationInstance?.worker?.id}">${allocationInstance?.worker?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.approver.label" default="Approver" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${allocationInstance?.approver?.id}">${allocationInstance?.approver?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocationInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.discussion.label" default="Discussion" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${allocationInstance.discussion}" var="d">
                                    <li><g:link controller="discussion" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.link.label" default="Link" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocationInstance, field: "link")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${allocationInstance?.status?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${allocationInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
