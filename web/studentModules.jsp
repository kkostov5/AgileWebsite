<%-- 
    Document   : studentModules
    Created on : 06-Mar-2017, 15:46:22
    Author     : Javier
--%>
<%@page import="Beans.Module"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Beans.LoggedIn"%>
<%@page import="Beans.ProgrammeOfStudy"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainpage_style.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script>
            function htmlbodyHeightUpdate() {
                var height3 = $(window).height()
                var height1 = $('.nav').height() + 50
                height2 = $('.main').height()
                if (height2 > height3) {
                    $('html').height(Math.max(height1, height3, height2) + 10);
                    $('body').height(Math.max(height1, height3, height2) + 10);
                } else
                {
                    $('html').height(Math.max(height1, height3, height2));
                    $('body').height(Math.max(height1, height3, height2));
                }

            }
            $(document).ready(function () {
                htmlbodyHeightUpdate()
                $(window).resize(function () {
                    htmlbodyHeightUpdate()
                });
                $(window).scroll(function () {
                    height2 = $('.main').height()
                    htmlbodyHeightUpdate()
                });
            });
        </script>
    </head>
    <body>
        <nav class="navbar navbar-inverse sidebar" role="navigation" style="position: fixed;">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-sidebar-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">QuizUp</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <% LoggedIn login = (LoggedIn) session.getAttribute("LoggedIn");%>
                        <form method="Post" action="MainPage" id='info'>
                            <p>Information about the user.<i> <br>Username: <%=login.getUsername()%><br>Type: <%=login.getType()%> </i></p>
                        </form>
                        <li class="active"><a href="mainpage.jsp" >Home<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>
                        <li id="pos" ><a>

                                <form method="Post" action="MainPage">
                                    <input type="submit" name="type" value="Programme of Study" id="submit">
                                </form>
                                <br>
                                <form method="Post" action="MainPage">
                                    <input type="submit" name="type" value="Favourites" id="submit">
                                </form>
                            </a>
                        <li class="active">
                            <a>
                                <form method="Get" action="Modules">
                                    <input type="submit" value="Modules" id="submit"><span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-book"></span>
                                </form>
                            </a>
                        </li>
                        <li class="active">
                            <a>
                                <form method="POST"  action="Logout">
                                    <button type="submit" style="float:left; background:none; border:none; margin:0; padding:0;">Log out</button>
                                    <span style="font-size:16px;"  class="pull-right hidden-xs showopacity glyphicon glyphicon-log-out"></span>
                                </form>
                            </a>

                        </li>


                    </ul>
                </div>
            </div>
        </nav>
                        
        
        
        <%

            ProgrammeOfStudy quizModules = (ProgrammeOfStudy) session.getAttribute("QuizDetails");
            int ID = (Integer) session.getAttribute("QuizID");
        %>

        <div class="main">
            <div class="page-header" style="margin-left: 2%;">

                <h1>Programmes Of Study</h1>
                <form method="Post" action="GetModules">
                    <input type="hidden" name="id" value="<%="1"%>"/> <!-- this value sends you to that pos after submitting choices -->   
                    <input type='hidden' id= 'hiddenField' name="moduleChoice" value='' />
                    <input type="submit" class="btn btn-lg btn-primary" id='button' style=" color: white; float: right; position: relative; bottom: 55px; margin-right: 20px; display: none;" value="Submit Choices"/>
                </form>
<%=session.getAttribute("test")%>


            </div> 
            <%
                ArrayList<ProgrammeOfStudy> pos = (ArrayList<ProgrammeOfStudy>) request.getAttribute("pos");
                for (int i = 0; i < pos.size(); i++) {
            %>
            <div class="Outer">

                <form method="Post" action="GetModules" style="height: 100%;">

                    <input type="hidden" name="id" value="<%=pos.get(i).getID()%>"/>
                    <input type="hidden" name="type" value="module"/>
                    <input class="Inner" type="submit" name="info" value="<%=pos.get(i).getName()%>"/>
                </form>

            </div>
            <%
                }

                ArrayList<Module> mod = (ArrayList<Module>) request.getAttribute("modules");

                if (mod != null) {
            %>
            <div class="page-header" style="margin-left: 2%;">
                <h2>Modules </h2>

            </div> 
            <%
                for (int i = 0; i < mod.size(); i++) {
            %>



            <div class="Outer">
                <input type="hidden" name="id" value="<%=mod.get(i).getID()%>"/>
                <div class="Inner1" style="text-align: center; vertical-align: middle; line-height: 80px;">
                    <%=mod.get(i).getName()%><button class="btton" id="<%=mod.get(i).getID()%>" onClick="reply_click(this.id)">&#10003;</button>
                </div>

            </div>
            <%
                    }
                }
            %>

        </div>
        <style>

            .btton{
                height: 100%;
                border: none;
                border-radius:0px 10px 10px 0px;
                background-color: white;
                float: right;
                cursor: pointer;
            }

            .btton:hover {
                background: rgba(101, 217, 80, 0.3);

            }
        </style>
        <script>
            var IDs = "";

            function reply_click(clicked_id)
            {
                document.getElementById(clicked_id).style.background = "rgba(101, 217, 80, 0.4)";
                document.getElementById('button').style.display = "block";
                IDs = IDs + " " + clicked_id;
                alert(IDs);
                document.getElementById('hiddenField').value = IDs;
            }
        </script>
    </body>
</html>
