package img;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import utility.DBClose;
import utility.DBOpen;

public class ImgDAO {
	public List imgRead(int imgno){
		List list = new ArrayList();
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM  ");
		sql.append("   (  ");
		sql.append("      select    ");
		sql.append("          lag(imgno,2)     over (order by imgno) pre_imgno2,    ");
		sql.append("          lag(imgno,1)     over (order by imgno ) pre_imgno1,   ");
		sql.append("          imgno,  ");
		sql.append("          lead(imgno,1)    over (order by imgno) nex_imgno1,    ");
		sql.append("          lead(imgno,2)    over (order by imgno) nex_imgno2,    ");
		sql.append("          lag(filename,2)  over (order by imgno) pre_file2,     ");
		sql.append("          lag(filename,1)  over (order by imgno ) pre_file1,  ");
		sql.append("          filename,   ");
		sql.append("          lead(filename,1) over (order by imgno) nex_file1,  ");
		sql.append("          lead(filename,2) over (order by imgno) nex_file2   ");
		sql.append("          from (  ");
		sql.append("               SELECT imgno, filename   ");
		sql.append("               FROM img2 ");
		sql.append("               ORDER BY imgno DESC  ");
		sql.append("          )  ");
		sql.append("   )  ");
		sql.append("   WHERE imgno = ? ");
		
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int[] noArr = 
					   {
						rs.getInt("pre_imgno2"),
						rs.getInt("pre_imgno1"),
						rs.getInt("imgno"),
						rs.getInt("nex_imgno1"),
						rs.getInt("nex_imgno2")
					    };
				String[] files = 
					    {
						rs.getString("pre_file2"),
						rs.getString("pre_file1"),
						rs.getString("filename"),
						rs.getString("nex_file1"),
						rs.getString("nex_file2")
						};
				
				list.add(files);
				list.add(noArr);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(con, pstmt, rs);
		}
				
		return list;
	}
	
	
	public boolean paswdCheck(int imgno,String passwd){
		boolean flag = false;
		
		return flag;
	}
	
	public int total(String col, String word){
		int total = 0;
		
		return total;
	}
	
	public List<ImgDTO> list(Map map){
		List<ImgDTO> list = new ArrayList<ImgDTO>();
		
		return list;
	}
	
	public ImgDTO read(int imgno){
		ImgDTO dto = null;
		Connection con = DBOpen.getConnection();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT imgno, wname, title, content,filename FROM img2 ");
		sql.append(" WHERE imgno=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new ImgDTO();
				dto.setImgno(rs.getInt("imgno"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DBClose.close(con, pstmt, rs);
		}
		
		
		return dto;
	}
	
	public boolean create(ImgDTO dto){
		boolean flag = false;
		
		return flag;
	}
	public boolean update(ImgDTO dto){
		boolean flag = false;
		
		return flag;
	}
	public boolean delete(int imgno){
		boolean flag = false;
		
		return flag;
	}
}
