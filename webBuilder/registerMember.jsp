<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DataEntity.MasterCardData,java.text.SimpleDateFormat" %>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="masterCardManager" class="manager.MasterCardManager" scope="page" />
<%
	// 마스터 카드 정보
    String masterName[] = { "창천의 대현자 옥시겐","정적의 문지기 아조트","집행자 클로어",
							"정찰조장 카메따","기술장교 아르비따","선발대장 그라비타찌야",
							"학살자 알폰소","주술사 호세","야수의 친구 브루노"};
	String masterImagePath[] = {"","","","","","","","",""};
%>

<!DOCTYPE HTML>
<html>
 <head>
  <title>***** Frontiers Story *****</title>
  <script src = "./common/common.js"></script>
  <script src = "./common/registerMember.js"></script>
 
  <meta charset="UTF-8" />
  <link rel="stylesheet" type="text/css" href="common/reset.css" />
  <link rel="stylesheet" type="text/css" href="common/layout_l.css" /> 
  <link rel="stylesheet" type="text/css" href="common/registerMember.css" />
  <!--[if gte IE 7]>
  		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  		<script src="js/IE8.js"></script>
  <![endif]-->
 </head>
 
  <%@ include file = "./Header.jspf" %>  
  
      <!-- contentsMain Start -->
      <div id="contentsMain" >
        <h2 class="titleBg"><span>회원 가입 페이지</span></h2>
        <form id="registerForm" name="registerForm" action="registerMemberProc.jsp" method="post">
        	 <h1><span>Frontiers에 오신것을 환영합니다.</span></h1>
		<table>
			<tr>
				<td>
					<table>
						<tr>
							<td class="tdgray" > 아이디 </td>
							<td class="tdwhite">
								<input type="text" name="userid" id="userid" size="16" maxlength="10" >
								<input type="button" id="btnOriginal" value="중복확인" 
								onClick="MM_openBrWindow('./userid_check.jsp','userid_check','width=320,height=230,resizable=no,scrollbars=no');" style="cursor:pointer">
								(영문+숫자 5~10자리)
							</td>
						</tr>
						<tr> 
							<td class="tdgray">비밀번호</td>
							<td class="tdwhite" >
								<input type="password" id="password" name="password" size="15" maxlength="15" >
								다시한번
								<input type="password" id="password2" name="password2" size="15" maxlength="15" >
								(영문+숫자 4~15자리)
							</td>
						</tr>
						<tr>
							<td class="tdgray">EMAIL</td>
						    <td class="tdwhite" >
								<input type="text" name="email" maxlength="50" >
							</td>
						</tr>
						<tr>
							<td class="tdgray">종족</td>
							<td class="tdwhite">
								<span class="cellStyle">
									<select name="axis" onchange="dispList(this.value);">
										<option value="가르드" >가르드</option>
										<option value="이노스트" >이노스트</option>
										<option value="홈버" >홈버</option>
									</select>
								</span>
							</td>
						</tr>
						<!--마스터 정보 시작-->
						<tr>
							<td class="tdgray"> 마스터선택 </td>
                            <td class="tdwhite" align="left" valign="top"> 
                            	<div id = "masterDisplay1" style="display:block">
	                                <table>
	                                  <tr>
											<td width="160">
												<input type="radio" name="master" value="1" checked/>
												<label><%=masterName[0]%></label>
											</td>
											<td width="160">
												<input type="radio" name="master" value="2" />
												<label><%=masterName[1]%></label>
											</td>
											<td width="170">
												<input type="radio" name="master" value="3" />
												<label><%=masterName[2]%></label>
											</td>
	                                  </tr>
	                                  <tr>
	                                       <td width="150"><img src="./images/masterCard/masterCard_0.jpg" width="140" height="185" /></td>
	                                       <td width="150"><img src="./images/masterCard/masterCard_1.jpg" width="140" height="185" /></td>
	                                       <td width="150"><img src="./images/masterCard/masterCard_2.jpg" width="140" height="185" /></td>
	                                  </tr>
	                                </table>
                                </div>
                                <div id = "masterDisplay2" style="display:none">
	                                <table>
	                                  <tr>
											<td width="160">
												<input type="radio" name="master" value="4" />
												<label><%=masterName[3]%></label>
											</td>
											<td width="160">
												<input type="radio" name="master" value="5" />
												<label><%=masterName[4]%></label>
											</td>
											<td width="170">
												<input type="radio" name="master" value="6" />
												<label><%=masterName[5]%></label>
											</td>
	                                  </tr>
	                                  <tr>
	                                       <td width="150"><img src="./images/masterCard/masterCard_3.jpg" width="140" height="185" /></td>
	                                       <td width="150"><img src="./images/masterCard/masterCard_4.jpg" width="140" height="185" /></td>
	                                       <td width="150"><img src="./images/masterCard/masterCard_5.jpg" width="140" height="185" /></td>
	                                  </tr>
	                                </table>
                                </div>
                                <div id = "masterDisplay3" style="display:none">
	                                <table>
	                                  <tr>
											<td width="160">
												<input type="radio" name="master" value="7" />
												<label><%=masterName[6]%></label>
											</td>
											<td width="160">
												<input type="radio" name="master" value="8" />
												<label><%=masterName[7]%></label>
											</td>
											<td width="170">
												<input type="radio" name="master" value="9" />
												<label><%=masterName[8]%></label>
											</td>
	                                  </tr>
	                                  <tr>
	                                       <td width="150"><img src="./images/masterCard/masterCard_6.jpg" width="140" height="185" /></td>
	                                       <td width="150"><img src="./images/masterCard/masterCard_7.jpg" width="140" height="185" /></td>
	                                       <td width="150"><img src="./images/masterCard/masterCard_8.jpg" width="140" height="185" /></td>
	                                  </tr>
	                                </table>
                                </div>
                                <br/>
                                <div style="float:left; margin-left:10px;">
                                      <img alt="" src="./images/registerMember/btn_Master.jpg" onclick="Click_CharacterVote();" style="cursor:pointer;"/>
                                </div> 
                                <div style="float:left;">
                                      <span class="red">* 처음 게임에서 사용할 마스터를 결정하시면 해당 마스터 카드와 기본덱을 드립니다.<br /> </span>
                                </div>           
                             </td>
                          </tr>
                          <!--마스터 정보 끝-->
                       <tr>
                          <td height="1" colspan="2"></td>
                       </tr>
                     </table>
                  </td>      
				</tr>						 
			</table>
			<table>
				<tr>
					<td align="center">
						<input type="hidden" name="userid_check">
						<p class="btnRow">
							<input type="button" id="btnSubmit" value="등록" onClick="doSubmit();" style="cursor:pointer">
							<input type="button" id="btnSubmit" value="메인으로" onClick="goMainPage();" style="cursor:pointer">
						</p>
					</td>
				</tr>
			</table>
		</form>
      </div>
      <!-- contentsMain End --> 
      
  <%@ include file = "./Foot.jspf" %>
</html>