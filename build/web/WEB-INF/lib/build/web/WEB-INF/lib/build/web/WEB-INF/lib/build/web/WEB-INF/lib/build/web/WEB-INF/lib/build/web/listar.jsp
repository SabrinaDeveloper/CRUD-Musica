<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LISTA</title>
       
    </head>
    <body>
        <style>
            table{
               
                width: 800px;
                height: 100px;
                background-color: #F0FFF0;
                margin: -8px auto; /* Centraliza horizontalmente */
                border: none;
                margin-left: 94px;
                border: none;
                border-radius: 4px;
                
            } 
            th{
                font-size: 20px;
                font-weight: 500;
                border: 1px solid #696969;
                border-radius: 4px;

            }
            tr{
                font-size: 20px;
                color:#2F4F4F;
                
            }
            td{
                 border: 1px solid #696969;
                 font-family: 'Joan';
                 border-radius: 4px;
            }
            /* Media Queries para telas de tablets (768px a 1024px) */
@media (max-width: 1024px) and (min-width: 768px) {
      table{
               
                width: 800px;
                background-color: #F0FFF0;
                margin: -8px auto; /* Centraliza horizontalmente */
                border: none;
                margin-left: 94px;
                border: none;
                border-radius: 4px;
                
            } 
            th{
                font-size: 20px;
                font-weight: 500;
                border: 1px solid #696969;
                border-radius: 4px;

            }
            tr{
                font-size: 20px;
                color:#2F4F4F;
                
            }
            td{
                 border: 1px solid #696969;
                 font-family: 'Joan';
                 border-radius: 4px;
            }
    
}

            
        </style>
      
        
        <%
            try {
            // Fazer a conexao com o banco de dados
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/app_musicas";
            String user="root";
            String password="";
            conecta=DriverManager.getConnection(url,user,password);
            // Lista os dados  da tabela produto do banco de dados
            String sql=("SELECT * FROM musicas");
            st=conecta.prepareStatement(sql);
            // ResultSet serve para guardar aquilo que é traido do BD
            ResultSet rs=st.executeQuery();      
        %>
        
        <table border="1">
            <tr>
                <th style="padding: 10px;" >Id</th>
                <th style="padding: 10px;">Nome Da Música</th>
                <th>Nome Do Artista</th>
                <th>Duração</th>
                           
            </tr>
            <%
                while (rs.next()){                               
            %>
            <tr>
                <td>
                    <%= rs.getInt("id")%>
                </td>
                <td>
                    <%= rs.getString("nome_musica")%>
                </td>
                <td>
                    <%= rs.getString("nome_artista")%>
                </td>
                <td>
                    <%= rs.getTime("duracao")%>
                </td>
                
                <td>
                    <a href="editar.jsp?nome_musica=<%=rs.getString("nome_musica")%>"> <img src="imagens/Editar.png" widht="30px" height="30px" alt="Editar"/> </a>
                    
                </td>
                <td>
                    <a href="excluir.jsp?id=<%=rs.getInt("id")%>"><img src="imagens/Excluir.png" widht="30px" height="30px" alt="Excluir"/>
         </a>
                </td>
            </tr>
            <%
                }
                %>
        </table>
  
        <% 
            } catch (Exception x) {
                out.print ("Mensagem de erro: " + x.getMessage());
            }
        %>
    </body>
</html>