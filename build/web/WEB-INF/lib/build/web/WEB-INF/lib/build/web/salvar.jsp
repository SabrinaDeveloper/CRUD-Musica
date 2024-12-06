<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salvar</title>
    </head>
    <body>
        <style>
            *{
                background-color:  #333333;
                
            }
            button{
                
               background-color: #1DB954;
               padding: 9px 39px;
               border-radius: 35px;
               font-size: 20px;
               margin-top: 0%;
               margin-left: 62%;
               font-family: 'Playfair Display';
            }
               
            
        </style>
        <%
            String nome_musica = request.getParameter("nome");
            String nome_artista = request.getParameter("artista");
            String duracao_str = request.getParameter("duracao");
            Time duracao = null;

            // Verifica se o nome da música foi informado
            if (nome_musica == null || nome_musica.trim().isEmpty()) {
                out.print("<p style='color:red;font-size:30px;'>O nome da música não pode ser vazio.</p>");
                return;
            }

            Connection conecta = null;
            PreparedStatement st = null;

            try {
                // Verificando se a duração foi passada
                if (duracao_str != null && !duracao_str.isEmpty()) {
                    if (duracao_str.length() == 5 && duracao_str.indexOf(":") == 2) {
                        duracao_str = "00:" + duracao_str; // Adiciona "00:" caso a duração seja apenas "mm:ss"
                    }

                    // Convertendo a string para o tipo Time (completa em HH:mm:ss)
                    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
                    java.util.Date parsedTime = sdf.parse(duracao_str);
                    duracao = new Time(parsedTime.getTime());
                }

                // Se a duração for nula e não for permitida no banco de dados
                if (duracao == null) {
                    out.print("<p style='color:red;font-size:30px;'> A duração não pode ser vazia.</p>");
                    return;
                }

                // Conectando ao banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/app_musicas";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);

                // Inserindo os dados na tabela musicas
                String sql = "INSERT INTO musicas (nome, artista, duracao) VALUES (?, ?, ?)";
                st = conecta.prepareStatement(sql);
                st.setString(1, nome_musica);  // Insere o nome da música
                st.setString(2, nome_artista); // Insere o nome do artista
                st.setTime(3, duracao);        // Insere a duração

                st.executeUpdate(); // Executando o comando de inserção

                // Mensagem de sucesso
                out.print("<p style='color:green;font-size:41px;margin-top: 110px; margin-left: 50px;'> Música cadastrada com sucesso! </p>");
            } catch (Exception e) {
                String erro = e.getMessage();
                if (erro.contains("Duplicate entry")) {
                    out.print("<p style='color:blue;font-size:30px;'> Esta música já está cadastrada. </p>");
                } else {
                    out.print("<p style='color:red;font-size:35px; margin:auto;'>Erro: " + erro + "</p>");
                }
            } finally {
                // Fechar recursos para evitar vazamentos
                out.print("<p style='color:#F5FFFA; > Nome da música recebido: '" + nome_musica + "'</p>");

                try {
                    if (st != null) st.close();
                    if (conecta != null) conecta.close();
                } catch (SQLException e) {
                    out.print("<p style='color:red;font-size:41px ;'>Erro ao fechar recursos: " + e.getMessage() + "</p>");
                }
            }
        %>
        
        <button onclick="window.location.href='index.html'">Voltar</button>
    </body>
</html>
