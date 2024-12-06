<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Aluno</title>
        <link href="tela1.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            String nome_musica;
            nome_musica = request.getParameter("nome_musica");
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/app_musicas";
            String user="root";
            String password="";
            conecta =DriverManager.getConnection(url,user,password);
            
        String sql=("SELECT * FROM musicas WHERE nome_musica=?");
        st=conecta.prepareStatement(sql);
        
        st.setString(1, nome_musica);
        
        st.executeQuery();
        
        ResultSet resultado=st.executeQuery();
        
        if(!resultado.next()){
            out.print("Esta musica não foi localizado");
            
            }else { //se encontrou o produto na tabela, vamos
            //carregar estes dados dentro de um formulario
        %>
        <div class="campo_editar">
        <form action="editar_musica.jsp" method="post" >
                <p>
                    <label for="nome_musica">Nome Da Musica</label>
                    <input type="text" name="nome_musica" id="nome_musica" value="<%=resultado.getString("nome_musica")%>">
                </p>
                 <p>
                    <label for="nome_artista">Nome do Artista</label>
                    <input type="text" name="nome_artista" id="nome_artista" value="<%=resultado.getString("nome_artista")%>">
                </p>
                 <p>
                    <label for="duracao">Duração</label>
                    <input type="number" name="duracao" id="duracao" value="<%=resultado.getString("duracao")%>">
                </p>
                
                <p>
                    <button class="botao_editar" type="submit">SALVAR EDIÇÃO</button>
                    <button onclick="voltar()">Voltar</button>

    <script>
        function voltar() {
            // Redireciona para a página anterior no histórico
            window.history.back();
                </p>
               
            </form>
    </div>
                <%
            }        
                %>
    </body>
</html>
    
