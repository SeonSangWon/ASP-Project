<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //GET방식으로 MultiView변경
        string target = Request["target"];

        if(String.Equals(target,"introduction"))
        {
            MultiView1.ActiveViewIndex = 0;
        }
        else if(String.Equals(target,"information"))
        {
            MultiView1.ActiveViewIndex = 1;
        }
        else if(String.Equals(target,"guide"))
        {
            MultiView1.ActiveViewIndex = 2;
        }
        else
        {
            MultiView1.ActiveViewIndex = 3;
        }


    }

    //원스하우스 소개 버튼 클릭 시
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }

    //시설&객실안내 버튼 클릭 시
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {

        MultiView1.ActiveViewIndex = 1;
    }

    //이용안내&예약 버튼 클릭 시
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        MultiView1.ActiveViewIndex = 2;
    }

    //저녁식사 버튼 클릭 시
    protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
    {
        MultiView1.ActiveViewIndex = 3;
    }

    //외부전경
    protected void Button1_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        MultiView2.ActiveViewIndex = 0;
    }

    //내부전경
    protected void Button2_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        MultiView2.ActiveViewIndex = 1;
    }

    //시설&객실안내 > 예약하러가기
    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect(string.Format("main.aspx?target=" + "reserve"));
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script>
    function initialize() { 
	//37.487258, 126.820577 원스하우스 좌표값
	var Y_point = 37.487258; // Y 좌표
	var X_point = 126.820577; // X 좌표
	var zoomLevel = 17; // 첫 로딩시 보일 지도의 확대 레벨
	var markerTitle = "원스 하우스"; // 현재 위치 마커에 마우스를 올렸을때 나타나는 이름
	var markerMaxWidth = 300; // 마커를 클릭했을때 나타나는 말풍선의 최대 크기
	
	var contentString = '<div id="content">' +
	'<div id="siteNotice">' +
	'</div>' +
	'<h3 id="firstHeading" class="firstHeading">원스하우스</h3>' +
	'<div id="bodyContent">' +
	'<p>경기도 부천시 경인로 590<br />' +
    'Tel. 010.9935.7482<br />' +
	'Tel. 02)2610.0600</p>' +
	'</div>' +
	'</div>';

	 var myLatlng = new google.maps.LatLng(Y_point, X_point);
	 var mapOptions = {
	 zoom: zoomLevel,
	 center: myLatlng,
	 mapTypeId: google.maps.MapTypeId.ROADMAP
	 }
	 var map = new google.maps.Map(document.getElementById('map_view'), mapOptions);

	 var marker = new google.maps.Marker({
	 position: myLatlng,
	 map: map,
	 title: markerTitle
	 });

	 var infowindow = new google.maps.InfoWindow(
	 {
	 content: contentString,
	 maxWidth: markerMaxWidth
	 }
	 );

	 google.maps.event.addListener(marker, 'click', function() {
	 infowindow.open(map, marker);
	 });
	 }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="css/menu_body.css" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body onload="initialize()">
    <form id="form1" runat="server">
        <div>
            <div onclick="location.href='main.aspx';" align="center">  
                <asp:Image ID="Image1" runat="server" Width="300" ImageUrl="~/imgs/menu_1.jpg" />
                <asp:Image ID="Image2" runat="server" Width="600" ImageUrl="~/imgs/menu_2.jpg" />
            </div>
            <br />
            <div align="center">
                <asp:ImageButton ID="ImageButton1" runat="server" Width="200" ImageUrl="~/imgs/menu_3.jpg" OnClick="ImageButton1_Click" />
                <asp:ImageButton ID="ImageButton2" runat="server" Width="200" ImageUrl="~/imgs/menu_4.jpg" OnClick="ImageButton2_Click" />
                <asp:ImageButton ID="ImageButton3" runat="server" Width="200" ImageUrl="~/imgs/menu_5.jpg" OnClick="ImageButton3_Click" />
                <asp:ImageButton ID="ImageButton4" runat="server" Width="180" ImageUrl="~/imgs/menu_6(2).jpg" OnClick="ImageButton4_Click" />
            </div>
            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="1">
                <!-- 원스하우스 소개 -->
                <asp:View ID="View1" runat="server">
                    <asp:Table ID="Table1" runat="server" HorizontalAlign="Center">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Image ID="Image3" runat="server" Width="600" ImageUrl="~/imgs/introduce_1.jpg" />
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:Image ID="Image4" runat="server" Width="400" ImageUrl="~/imgs/introduce_2.jpg" />
                                <p>
                                <asp:Image ID="Image5" runat="server" Width="550" ImageUrl="~/imgs/introduce_3.jpg" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <asp:Table ID="Table2" runat="server" Width="100%" BackColor="Green">
                        <asp:TableRow>
                            <asp:TableCell Width="40%" HorizontalAlign="Center">
                                <asp:Image ID="Image6" runat="server" Width="300" ImageUrl="~/imgs/google_1.jpg" />
                                <div id="map_view" style="width:400px; height:400px;"></div>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:Image ID="Image7" runat="server" Width="400" ImageUrl="~/imgs/google_2.jpg" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:View>

                <!-- 시설&객실안내 -->
                <asp:View ID="View2" runat="server">
                    <link href="css/information.css" rel="stylesheet" type="text/css" />
                    <div class="page"> 
                    <asp:Table ID="Table3" runat="server" Width="100%" HorizontalAlign="Center">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Image ID="Image8" runat="server" Width="400" ImageUrl="~/imgs/information_2.jpg" />
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Button ID="Button1" runat="server" Text="외부전경" OnClick="Button1_Click" CssClass="fun-btn" />
                                &nbsp;&nbsp;
                                <asp:Button ID="Button2" runat="server" Text="내부전경" OnClick="Button2_Click" CssClass="fun-btn" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="2">
                                <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="0">
                                    <!-- 외부전경 -->
                                    <asp:View ID="View5" runat="server">
                                        <div style="margin-left:230px;">
                                        <asp:Image ID="Image9" runat="server" Width="250" ImageUrl="~/imgs/outside_1.jpg" />
                                        </div>
                                        <div align="center">
                                        <asp:Image ID="Image10" runat="server" Width="1000" ImageUrl="~/imgs/outside_2.jpg" />
                                        </div>
                                        <div style="margin-left:230px;">
                                            <asp:Image ID="Image11" runat="server" Width="250" ImageUrl="~/imgs/outside_3.jpg" />
                                        </div>
                                        <div align="center">
                                            <asp:Image ID="Image12" runat="server" Width="1000" ImageUrl="~/imgs/outside_4.jpg" />
                                        </div>
                                    </asp:View>

                                    <!-- 내부전경 -->
                                    <asp:View ID="View6" runat="server">
                                        <div style="margin-left:230px;">
                                            <asp:Image ID="Image13" runat="server" Width="1000" ImageUrl="~/imgs/inside_1.jpg" />
                                        </div>
                                        <div style="margin-left:240px;">
                                            <asp:Image ID="Image14" runat="server" Width="500" ImageUrl="~/imgs/inside_2.jpg" />
                                        </div>
                                        <div style="margin-left:230px;">
                                            <asp:Image ID="Image15" runat="server" Width="1000" ImageUrl="~/imgs/inside_3.jpg" />
                                        </div>
                                        <div style="margin-left:240px;">
                                            <asp:Image ID="Image16" runat="server" Width="800" ImageUrl="~/imgs/inside_4.jpg" />
                                        </div>
                                        <div style="margin-left:240px;">
                                            <asp:Image ID="Image17" runat="server" Width="800" ImageUrl="~/imgs/inside_5.jpg" />
                                        </div>
                                    </asp:View>
                                </asp:MultiView>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    </div>
                </asp:View>

                <!-- 이용안내&예약 -->
                <asp:View ID="View3" runat="server">
                    <link href="css/information.css" rel="stylesheet" type="text/css" />
                    <asp:Table ID="Table4" runat="server" Width="90%">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="center">
                                <asp:Image ID="Image18" runat="server" Width="600" ImageUrl="~/imgs/guide_1.jpg" />
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:Image ID="Image19" runat="server" Width="400" ImageUrl="~/imgs/guide_2.jpg" />
                                <p>
                                    <asp:Image ID="Image20" runat="server" Width="400" ImageUrl="~/imgs/guide_3.jpg" />
                                <p>
                                    <asp:Button ID="Button3" runat="server" Text="예약하러가기"
                                        OnClick="Button3_Click" CssClass="fun-btn" />
                            </asp:TableCell>
                        </asp:TableRow>

                    </asp:Table>
                </asp:View>

                <!-- 저녁 식사 -->
                <asp:View ID="View4" runat="server">
                    <div align="center">
                        <asp:Image ID="Image21" runat="server" Width="1000" ImageUrl="~/imgs/dinner_1.jpg" />
                    </div>
                    <div align="center">
                        <asp:Image ID="Image22" runat="server" Width="800" ImageUrl="~/imgs/dinner_2.jpg" />
                    </div>
                </asp:View>

            </asp:MultiView>
        </div>
    </form>
</body>
</html>
