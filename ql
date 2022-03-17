using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using System.Data.SqlClient; 
namespace QL
{
    public partial class from_QLNH : Form
    {
        public from_QLNH()
        {
            InitializeComponent();
        }

        SqlConnection con;

        private void from_QLNH_Load(object sender, EventArgs e)
        {
            //string conString = ConfigurationManager.ConnectionStrings["QL Tien"].ConnectionString.ToString();
            con = new SqlConnection(@"Data Source=DESKTOP-V96NTQ5\TIEN;Initial Catalog=QUANLITHONGTIN;Integrated Security=True");
            con.Open();
            Display();
        }

        private void from_QLNH_FormClosing(object sender, FormClosingEventArgs e)
        {
            con.Close();
        }

        public void Display()
        {
            string sqlSELECT = "SELECT *FROM NHAHANG";
            SqlCommand cmd = new SqlCommand(sqlSELECT, con);
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            dsNhaHang.DataSource = dt;
        }

        private void txtadd_Click(object sender, EventArgs e)
        {
            string sqlINSET = "INSERT INTO NHAHANG VALUES(@MaNH,@TenNH,@DiaChi,@SDT)";
            SqlCommand cmd = new SqlCommand(sqlINSET,con);
            cmd.Parameters.AddWithValue("MaNH", txtMa.Text);
            cmd.Parameters.AddWithValue("TenNH", txtTen.Text);
            cmd.Parameters.AddWithValue("Diachi", txtDiachi.Text);
            cmd.Parameters.AddWithValue("SDT", txtSDT.Text);
            cmd.ExecuteNonQuery();
            Display();
        }
        private void txtEdit_Click(object sender, EventArgs e)
        {
            string sqlEdit = "UPDATE NHAHANG SET TenNH= @TenNH, DiaChi= @Diachi,SDT=@SDT WHERE MaNH = @MaNH ";
            SqlCommand cmd = new SqlCommand(sqlEdit, con);
            cmd.Parameters.AddWithValue("MaNH", txtMa.Text);
            cmd.Parameters.AddWithValue("TenNH", txtTen.Text);
            cmd.Parameters.AddWithValue("Diachi", txtDiachi.Text);
            cmd.Parameters.AddWithValue("SDT", txtSDT.Text);
            cmd.ExecuteNonQuery();
            Display();
        }

        private void txtDelete_Click(object sender, EventArgs e)
        {
            string sqlDelete = "DELETE FROM NHAHANG WHERE MaNH= @MaNH";
            SqlCommand cmd = new SqlCommand(sqlDelete, con);
            cmd.Parameters.AddWithValue("MaNH", txtMa.Text);
            cmd.Parameters.AddWithValue("TenNH", txtTen.Text);
            cmd.Parameters.AddWithValue("Diachi", txtDiachi.Text);
            cmd.Parameters.AddWithValue("SDT", txtSDT.Text);
            cmd.ExecuteNonQuery();
            Display();
        }

        private void txtSearch_Click(object sender, EventArgs e)
        {
            string sqlSearch = " SELECT *FROM NHAHANG WHERE MaNH = @MaNH  ";
            SqlCommand cmd = new SqlCommand(sqlSearch, con);
            cmd.Parameters.AddWithValue("MaNH", txtInputMa.Text);
            cmd.Parameters.AddWithValue("TenNH", txtTen.Text);
            cmd.Parameters.AddWithValue("Diachi", txtDiachi.Text);
            cmd.Parameters.AddWithValue("SDT", txtSDT.Text);
            cmd.ExecuteNonQuery();
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            dsNhaHang.DataSource = dt;
        }
    }
}
