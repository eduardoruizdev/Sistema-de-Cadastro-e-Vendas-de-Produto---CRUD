<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="CODIGOLOJAS.Pages.index" %>

<!DOCTYPE html>
<html lang="pt-br">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>CODIGO LOJAS | Hub de Vendas Premium</title>
    
    <!-- Fonts & UI Kit -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />

    <style>
        :root { --primary: #3b82f6; --dark: #0f172a; --bg: #f8fafc; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: #1e293b; overflow-x: hidden; }

        /* Navbar Glassmorphism */
        .navbar-custom { background: rgba(15, 23, 42, 0.95); backdrop-filter: blur(12px); border-bottom: 1px solid rgba(255,255,255,0.1); padding: 1rem 0; }
        .navbar-brand { font-weight: 800; letter-spacing: -1px; text-transform: uppercase; }

        /* Propaganda Dinâmica */
        .ad-banner { 
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            border-radius: 35px; padding: 80px 60px; color: white; margin-top: 110px;
            position: relative; overflow: hidden; border: 1px solid rgba(255,255,255,0.1);
        }
        .ad-circle { position: absolute; top: -50%; right: -10%; width: 600px; height: 600px; background: radial-gradient(circle, rgba(59, 130, 246, 0.2) 0%, transparent 70%); }

        /* Filtros de Categoria */
        .category-scroll { display: flex; gap: 12px; overflow-x: auto; padding: 15px 0; scrollbar-width: none; }
        .category-scroll::-webkit-scrollbar { display: none; }
        .btn-category { 
            white-space: nowrap; border-radius: 50px; padding: 12px 28px; 
            background: white; border: 1px solid #e2e8f0; color: #64748b; 
            font-weight: 600; transition: 0.3s; text-decoration: none;
        }
        .btn-category.active { background: var(--primary); color: white; border-color: var(--primary); box-shadow: 0 10px 20px rgba(59, 130, 246, 0.2); }

        /* Product Cards */
        .product-card { border: none; border-radius: 28px; transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); background: white; }
        .product-card:hover { transform: translateY(-12px); box-shadow: 0 25px 50px rgba(0,0,0,0.08); }
        .product-img-box { height: 240px; background: #fcfcfc; padding: 30px; display: flex; align-items: center; justify-content: center; }
        .product-img { max-height: 100%; max-width: 100%; object-fit: contain; }

        /* Floating Elements */
        .cart-float { width: 65px; height: 65px; background: var(--primary); border: none; box-shadow: 0 15px 30px rgba(59, 130, 246, 0.4); }
        footer { background: var(--dark); color: #94a3b8; padding: 80px 0 40px; margin-top: 100px; }
        .dev-brand { color: var(--primary); font-weight: 700; text-decoration: none; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
            <div class="container">
                <a class="navbar-brand" href="index.aspx"><i class="fas fa-bolt me-2 text-primary"></i>CODIGO LOJAS</a>
                <a href="/Pages/Login.aspx" class="btn btn-outline-light rounded-pill px-4 fw-bold border-0">
                    <i class="far fa-user-circle me-2"></i>Área Restrita
                </a>
            </div>
        </nav>

        <div class="container">
            <!-- Banner de Marketing Dinâmico -->
            <section class="ad-banner" data-aos="zoom-in">
                <div class="ad-circle"></div>
                <div class="position-relative" style="z-index: 2;">
                    <span class="badge bg-primary mb-3 px-3 py-2 rounded-pill">EXCLUSIVIDADE</span>
                    <h1 class="display-4 fw-800 mb-3"><%= AdTitle %></h1>
                    <p class="lead opacity-75 mb-4 col-lg-8"><%= AdDesc %></p>
                    <a href="#vitrine" class="btn btn-light btn-lg rounded-4 px-5 fw-bold text-primary">Explorar Agora</a>
                </div>
            </section>

            <!-- Sistema de Filtros -->
            <section class="mt-5 mb-4" id="vitrine" data-aos="fade-up">
                <h5 class="fw-bold mb-3"><i class="fas fa-filter me-2 text-primary"></i>Departamentos</h5>
                <div class="category-scroll">
                    <a href="index.aspx#vitrine" class="btn-category <%= string.IsNullOrEmpty(Request.QueryString["cat"]) ? "active" : "" %>">Tudo</a>
                    <asp:Repeater ID="rptCategorias" runat="server">
                        <ItemTemplate>
                            <a href='index.aspx?cat=<%# Eval("IdCategoria") %>#vitrine' 
                               class='btn-category <%# Request.QueryString["cat"] == Eval("IdCategoria").ToString() ? "active" : "" %>'>
                               <%# Eval("Nome") %>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>

            <!-- Vitrine de Produtos -->
            <main class="row g-4">
                <asp:Repeater ID="rptProdutos" runat="server">
                    <ItemTemplate>
                        <div class="col-sm-6 col-lg-3" data-aos="fade-up">
                            <div class="card h-100 product-card">
                                <div class="product-img-box">
                                    <img src='<%# Eval("Imagem") %>' class="product-img" alt='<%# Eval("Nome") %>' onerror="this.src='https://via.placeholder.com/400x400?text=Produto'">
                                </div>
                                <div class="card-body p-4 d-flex flex-column">
                                    <h5 class="fw-bold mb-2 text-dark"><%# Eval("Nome") %></h5>
                                    <p class="text-muted small flex-grow-1"><%# Eval("Descricao") %></p>
                                    <div class="mt-3">
                                        <span class="text-muted small d-block mb-1">Cód: #<%# Eval("Codigo") %></span>
                                        <h4 class="fw-800 text-dark mb-0">`R$ <%# Eval("Valor") %>`</h4>
                                    </div>
                                    <!-- Botão com Correção de Contexto (this) e Tipagem -->
                                    <button type="button" class="btn btn-dark w-100 mt-4 py-3 rounded-4 fw-bold shadow-sm" 
                                        onclick="adicionarAoCarrinho(this, '<%# Eval("Id") %>', '<%# Eval("Codigo") %>', '<%# Eval("Nome") %>', '<%# Eval("Valor").ToString().Replace(",", ".") %>')">
                                        <i class="fas fa-cart-plus me-2"></i> Adicionar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </main>
        </div>

        <footer>
            <div class="container text-center">
                <div class="mb-4">
                    <a href="https://instagram.com/codigolojas" target="_blank" class="text-white me-3 fs-4"><i class="fab fa-instagram"></i></a>
                    <a href="https://wa.me/5513997757715" target="_blank" class="text-white fs-4"><i class="fab fa-whatsapp"></i></a>
                </div>
                <p class="small mb-1">&copy; 2024 CODIGO LOJAS. Excelência em Curadoria Digital.</p>
                <p class="small">Powered by <a href="#" class="dev-brand">devpronto web development</a></p>
            </div>
        </footer>

        <!-- Carrinho Flutuante -->
        <button type="button" class="btn btn-primary rounded-circle cart-float shadow-lg fixed-bottom m-4" data-bs-toggle="modal" data-bs-target="#modalCarrinho">
            <i class="fas fa-shopping-bag fa-lg"></i>
            <span id="cart-count" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
        </button>

        <!-- Modal do Carrinho -->
        <div class="modal fade" id="modalCarrinho" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 30px;">
                    <div class="modal-header border-0 p-4 pb-0">
                        <h5 class="modal-title fw-bold">Meu Carrinho</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div id="lista-carrinho" class="list-group list-group-flush mb-4"></div>
                        <div class="bg-light p-4 rounded-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-muted fw-bold">Total do Pedido</span>
                                <h3 id="total-carrinho" class="fw-bold mb-0 text-dark">R$ 0,00</h3>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0 p-4 pt-0">
                        <button type="button" class="btn btn-success w-100 py-3 fw-bold rounded-4 shadow-sm" onclick="finalizarCompra()">
                            <i class="fab fa-whatsapp me-2"></i> Finalizar via WhatsApp
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 1000, once: true });

        let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];

        function adicionarAoCarrinho(btn, id, codigo, nome, valor) {
            const valorNum = parseFloat(valor);
            carrinho.push({ id, codigo, nome, valor: valorNum });
            salvar();
            renderizar();

            // Feedback visual no botão
            if (btn) {
                const original = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-check me-2"></i> No Carrinho';
                btn.classList.replace('btn-dark', 'btn-success');
                setTimeout(() => {
                    btn.innerHTML = original;
                    btn.classList.replace('btn-success', 'btn-dark');
                }, 1200);
            }
        }

        function salvar() { localStorage.setItem('carrinho', JSON.stringify(carrinho)); }

        function renderizar() {
            const lista = document.getElementById('lista-carrinho');
            const totalSpan = document.getElementById('total-carrinho');
            const countSpan = document.getElementById('cart-count');

            lista.innerHTML = carrinho.length === 0 ?
                '<div class="text-center py-5 text-muted"><i class="fas fa-shopping-basket fa-3x mb-3 opacity-25"></i><p>Seu carrinho está vazio.</p></div>' : '';

            let total = 0;
            carrinho.forEach((item, index) => {
                total += item.valor;
                lista.innerHTML += `
                    <div class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3 bg-transparent">
                        <div>
                            <h6 class="fw-bold mb-0">${item.nome}</h6>
                            <small class="text-muted">Ref: ${item.codigo}</small><br>
                            <span class="text-primary small fw-bold">R$ ${item.valor.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</span>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-danger border-0 rounded-pill" onclick="removerItem(${index})">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </div>`;
            });

            totalSpan.innerText = `R$ ${total.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}`;
            countSpan.innerText = carrinho.length;
        }

        function removerItem(index) {
            carrinho.splice(index, 1);
            salvar();
            renderizar();
        }

        function finalizarCompra() {
            if (carrinho.length === 0) return;

            let texto = "🛒 *NOVO PEDIDO - CODIGO LOJAS*\n";
            texto += "━━━━━━━━━━━━━━━━━━━━\n\n";
            let total = 0;

            carrinho.forEach(item => {
                texto += `🔹 *[Cód: ${item.codigo}] ${item.nome}*\n   R$ ${item.valor.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}\n\n`;
                total += item.valor;
            });

            texto += "━━━━━━━━━━━━━━━━━━━━\n";
            texto += `💰 *TOTAL: R$ ${total.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}*`;

            const url = `https://wa.me/5513997757715?text=${encodeURIComponent(texto)}`;
            window.open(url, '_blank');
        }

        document.addEventListener('DOMContentLoaded', renderizar);
    </script>
</body>
</html>