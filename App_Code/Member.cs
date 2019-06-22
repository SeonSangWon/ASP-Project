using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Member의 요약 설명입니다.
/// </summary>
public class Member
{
    string _constring;
    public Member()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //

        //해당 클래스 내에서 DB연결
        _constring = System.Configuration.ConfigurationManager.ConnectionStrings["MyAspDB"].ConnectionString;
    }
    
    //관리자 - 회원목록보기
    public DataSet SelectMembers()
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Select * From member Order By checkin DESC";
        SqlCommand cmd = new SqlCommand(sql, con);

        SqlDataAdapter ad = new SqlDataAdapter();
        ad.SelectCommand = cmd;

        DataSet ds = new DataSet();
        ad.Fill(ds);

        return ds;
    }

    //회원정보
    public DataSet SelectMember(string phone)
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Select * From member Where phone=@phone";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@phone", phone);

        SqlDataAdapter ad = new SqlDataAdapter();
        ad.SelectCommand = cmd;

        DataSet ds = new DataSet();
        ad.Fill(ds);

        return ds;
    }

    //로그인
    public Boolean loginMember(string phone, string name)
    {
        Boolean flag = false;
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Select * From member Where phone=@phone AND name=@name";
        var cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@phone", phone);
        cmd.Parameters.AddWithValue("@name", name);
        
        con.Open();
        var rd = cmd.ExecuteReader();

        if (rd.HasRows)
        {
            if (rd.Read())
            {
                if (rd["phone"].ToString().Equals(phone))
                {
                    flag = true;
                }
            }
        }

        return flag;
    }

    //회원가입
    public void insertMember(string phone, string name, string time, string email, string emailcheck, string room,
        string day, string price, string checkin, string checkout, string bank, string register)
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Insert Into member Values" +
            "(@phone,@name,@time,@email,@emailcheck,@room,@day,@price,@checkin,@checkout,@bank,@reg_date)";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@phone", phone);
        cmd.Parameters.AddWithValue("@name", name);
        cmd.Parameters.AddWithValue("@time", time);
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@emailcheck", emailcheck);
        cmd.Parameters.AddWithValue("@room", room);
        cmd.Parameters.AddWithValue("@day", day);
        cmd.Parameters.AddWithValue("@price", price);
        cmd.Parameters.AddWithValue("@checkin", checkin);
        cmd.Parameters.AddWithValue("@checkout", checkout);
        cmd.Parameters.AddWithValue("@bank", bank);
        cmd.Parameters.AddWithValue("@reg_date", register);

        con.Open();
        cmd.ExecuteNonQuery();

        con.Close();
    }

    //회원정보 수정
    public void UpdateMember(string phone, string time, string email, string emailcheck, string checkin, string checkout)
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Update member Set time=@time, email=@email, emailcheck=@emailcheck, checkin=@checkin, checkout=@checkout Where phone=@phone";

        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@time", time);
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@emailcheck", emailcheck);
        cmd.Parameters.AddWithValue("@checkin", checkin);
        cmd.Parameters.AddWithValue("@checkout", checkout);
        cmd.Parameters.AddWithValue("@phone", phone);

        con.Open();
        cmd.ExecuteNonQuery();

        con.Close();
    }

    //관리자 - 회원정보 수정
    public void UpdateMaster(string phone, string name, string time, string email, string emailcheck, string room, string day,
        string price, string checkin, string checkout)
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Update member set name=@name, time=@time, email=@email, emailcheck=@emailcheck, room=@room," +
            "day=@day, price=@price, checkin=@checkin, checkout=@checkout Where phone=@phone";

        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@name", name);
        cmd.Parameters.AddWithValue("@time", time);
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@emailcheck", emailcheck);
        cmd.Parameters.AddWithValue("@room", room);
        cmd.Parameters.AddWithValue("@day", day);
        cmd.Parameters.AddWithValue("@price", price);
        cmd.Parameters.AddWithValue("@checkin", checkin);
        cmd.Parameters.AddWithValue("@checkout", checkout);
        cmd.Parameters.AddWithValue("@phone", phone);

        con.Open();
        cmd.ExecuteNonQuery();

        con.Close();
    }

    //회원탈퇴
    public void DeleteMember(string phone)
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Delete From member Where phone=@phone";

        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@phone", phone);

        con.Open();
        cmd.ExecuteNonQuery();

        con.Close();
    }
}