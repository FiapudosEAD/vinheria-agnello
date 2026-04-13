# Vinheria Agnello — Sprint 2
## Projeto de Transformação Digital | FIAP - Engenharia de Software

---

## Integrantes

- Felipe Genistretti Rodrigues – RM 556348
- Matheus Henriques do Amaral – RM 556957
- Rafael Porto Annunciato – RM 554939
- Jeniffer Moraes – RM 555448
- Pedro Schmitz – RM 555758

---

## Tecnologias

- **Java 17+** com Jakarta Servlets
- **Apache Tomcat 10.1**
- **JSP + JSTL** para as views
- **H2 Database** — banco em arquivo local, zero configuração (padrão)
- **Oracle Cloud ATP** — opcional para produção
- **HTML5 / CSS3 / JavaScript (ES6)**
- Padrão **MVC** (Model-View-Controller)

---

## Estrutura do Projeto

```
vinheria-agnello/
├── src/com/agnello/
│   ├── model/
│   │   ├── Usuario.java
│   │   └── Vinho.java
│   ├── dao/
│   │   ├── UsuarioDAO.java
│   │   └── VinhoDAO.java
│   ├── servlet/
│   │   ├── LoginServlet.java
│   │   ├── CadastroServlet.java
│   │   ├── CatalogoServlet.java
│   │   └── ProdutoServlet.java
│   └── util/
│       └── ConnectionFactory.java
├── webapp/
│   ├── WEB-INF/web.xml
│   ├── css/style.css
│   ├── js/script.js
│   ├── index.jsp
│   ├── login.jsp
│   ├── cadastro.jsp
│   ├── catalogo.jsp
│   ├── produto.jsp
│   ├── carrinho.jsp
│   └── logout.jsp
└── sql/schema.sql     ← DDL para Oracle Cloud (referência)
```

---

## Arquitetura MVC

```
[Navegador] → (request) → [Servlet (Controller)]
                                  |
                           [DAO (Model)] → [H2 / Oracle]
                                  |
                           [JSP (View)] → (response) → [Navegador]
```

---

## Como Rodar (IntelliJ IDEA + Tomcat 10.1)

### Pré-requisitos

| Ferramenta | Versão mínima |
|------------|---------------|
| JDK | 17+ |
| Apache Tomcat | 10.1 |
| IntelliJ IDEA | qualquer edição |

JARs necessários (baixe para `%USERPROFILE%\Downloads\`):

| JAR | Link |
|-----|------|
| H2 Database | https://repo1.maven.org/maven2/com/h2database/h2/2.2.224/h2-2.2.224.jar |
| JSTL 1.2 | https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar |

### Variáveis de Ambiente necessárias

| Variável | Exemplo de valor |
| -------- | ---------------- |
| `CATALINA_HOME` | `C:/Program Files/Apache Software Foundation/Tomcat 10.1` |
| `USERPROFILE` | Definida automaticamente pelo Windows |

### Passos

1. Defina a variável `CATALINA_HOME` apontando para o diretório do Tomcat
2. Abra o projeto no **IntelliJ IDEA**
3. **File → Project Structure → Modules → Dependencies** — adicione:
   - `%USERPROFILE%\Downloads\h2-2.2.224.jar`
   - `%USERPROFILE%\Downloads\jstl-1.2.jar`
   - `%CATALINA_HOME%\lib\servlet-api.jar`
4. Configure o Tomcat em **Run → Edit Configurations → + → Tomcat → Local**
5. Aba **Deployment**: adicione o artefato exploded apontando para `webapp/`
6. Clique em **Run** — o banco H2 é criado automaticamente em `%USERPROFILE%\agnello_db`
7. Acesse `http://localhost:8080`

> As tabelas `USUARIOS` e `VINHOS` (com os 10 vinhos) são criadas e populadas automaticamente na primeira execução. Não é necessário rodar nenhum script SQL.

---

## Banco de Dados

O projeto usa **H2** por padrão em modo Oracle-compatível:

```
URL:      jdbc:h2:~/agnello_db;AUTO_SERVER=TRUE;MODE=Oracle
Usuário:  sa
Senha:    (vazia)
```

Para usar **Oracle Cloud ATP** em produção, edite [ConnectionFactory.java](src/com/agnello/util/ConnectionFactory.java):

```java
private static final String URL = "jdbc:oracle:thin:@agnellodb_high?TNS_ADMIN=C:/wallet_agnello";
private static final String USER = "ADMIN";
private static final String PASSWORD = "SuaSenha";
private static final String DRIVER = "oracle.jdbc.OracleDriver";
```

Adicione `ojdbc11.jar` ao classpath e execute `sql/schema.sql` no Oracle SQL Worksheet.

---

## Funcionalidades

| Rota | Descrição |
|------|-----------|
| `/index.jsp` | Home com vitrine e destaques |
| `/CatalogoServlet` | Catálogo com filtro por tipo de vinho |
| `/ProdutoServlet?id=N` | Detalhe do produto |
| `/CadastroServlet` | Cadastro de novo usuário |
| `/LoginServlet` | Login com sessão |
| `/carrinho.jsp` | Carrinho de compras (localStorage) |
| `/logout.jsp` | Encerramento de sessão |

---

## Erros no VS Code

O plugin Java do VS Code pode exibir erros de "cannot find symbol" para classes de servlet. Para resolver, faça **Ctrl+Shift+P → Java: Clean Language Server Workspace** após a configuração inicial. O arquivo [.vscode/settings.json](.vscode/settings.json) já está configurado com os caminhos dos JARs.
