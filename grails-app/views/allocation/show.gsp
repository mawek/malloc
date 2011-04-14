<%@ page import="malloc.Allocation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="allocation.show.label"/></title>
    </head>
    <body>        
        <div class="body">
            <h1><g:message code="allocation.detail.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody> 
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocation, field: "name")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${message(code: 'allocation.status.'+allocation?.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${message(code: 'allocation.type.'+allocation?.type?.encodeAsHTML(), default: allocation?.type?.encodeAsHTML())}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.requester.label" default="Requester" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${allocation?.requester?.id}">${allocation?.requester?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.date.label" default="Date" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocation, field: "when")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.hours.label" default="Hours" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocation, field: "hours")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.worker.label" default="Worker" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${allocation?.worker?.id}">${allocation?.worker?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.approver.label" default="Approver" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${allocation?.approver?.id}">${allocation?.approver?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocation, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.discussion.label" default="Discussion" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${allocation.discussion}" var="d">
                                    <li><g:link controller="discussion" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="allocation.link.label" default="Link" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: allocation, field: "link")}</td>
                            
                        </tr>    
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${allocation?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
