-- ÍRIS · Óptica
-- Substitui o catálogo fictício da migração 0001 pelos 20 modelos
-- reais de grife (Ray-Ban, Burberry, Michael Kors, Vogue Eyewear,
-- Armani Exchange, Coach, Marc Jacobs, Arnette, Kipling). Rode este
-- arquivo DEPOIS de 0001, no SQL Editor do projeto Supabase.
--
-- As fotos de cada produto NÃO ficam no banco — elas são arquivos
-- estáticos publicados junto com o site em produtos/<id>/1.png ..
-- <n_fotos>.png. Este catálogo só guarda quantas fotos existem
-- (n_fotos) e qual delas é a capa (capa).
--
-- PREÇOS SÃO PLACEHOLDER — atualize a coluna `preco` com os valores
-- reais antes de divulgar a loja.

drop table if exists public.armacoes cascade;

create table public.armacoes (
  id text primary key,
  marca text not null,
  nome text not null,
  shape text not null,
  cor text not null,
  mat text not null default '',
  preco numeric(10,2) not null,
  tag text not null default '',
  descricao text not null default '',
  n_fotos int not null default 1,
  capa int not null default 2,
  ordem int not null default 0,
  ativo boolean not null default true,
  criado_em timestamptz not null default now()
);

alter table public.armacoes enable row level security;

create policy "armacoes_select_publica"
  on public.armacoes for select
  to anon, authenticated
  using (ativo = true);

insert into public.armacoes (id,marca,nome,shape,cor,mat,preco,tag,descricao,n_fotos,capa,ordem) values
('rayban-bill','Ray-Ban','Bill','aviador','#8a5a3c','Acetato',899,'Mais vendido','Aviador dos anos 60 revisitado em acetato tartaruga. Um ícone que nunca saiu de moda.',7,2,1),
('burberry-be4403','Burberry','BE4403','quadrada','#0d0d0d','Acetato',1190,'Premium','Quadrada em acetato preto brilhante com o check Burberry na haste. Peso e presença de grife.',5,2,2),
('burberry-be4436u','Burberry','BE4436U','gatinho','#0d0d0d','Acetato',1230,'','Cat-eye em acetato preto com estampa xadrez na haste. Assinatura reconhecível de qualquer ângulo.',5,2,3),
('rayban-oval','Ray-Ban','Oval','redonda','#b8935a','Metal',850,'','Redonda em metal fino com ponte dupla. O desenho minimalista que atravessa gerações.',6,2,4),
('michael-kors-asheville','Michael Kors','Asheville','quadrada','#141414','Acetato',690,'','Quadrada oversized com hastes em degradê. Volume calculado pra rostos delicados.',5,2,5),
('coach-cby91','Coach','CBY91','gatinho','#141414','Acetato',780,'','Cat-eye contemporâneo com monograma discreto. Equilibra rostos ovais e quadrados.',6,2,6),
('marc-jacobs-marc-807s','Marc Jacobs','MARC 807/S','gatinho','#101010','Acetato',720,'Novo','Cat-eye com o logo Marc Jacobs impresso na haste. Atitude gráfica, sem meio-termo.',5,2,7),
('armani-exchange-ax4135s','Armani Exchange','AX4135S','retangular','#1a1a2e','Acetato',590,'','Retangular urbano com hastes em degradê. Traço limpo pra usar todo dia.',4,2,8),
('armani-exchange-ax4146su','Armani Exchange','AX4146SU','quadrada','#141414','Metal',620,'','Quadrada em metal fosco com detalhe geométrico na haste. Discreta e precisa.',5,2,9),
('vogue-eyewear-vo5601s','Vogue Eyewear','VO5601S','quadrada','#5a6b52','Acetato',430,'','Quadrada em acetato verde translúcido com armação dourada fina. Um toque de cor sem exagerar.',6,2,10),
('vogue-eyewear-vo5520s','Vogue Eyewear','VO5520S','gatinho','#e8c9c9','Acetato',440,'Novo','Cat-eye em acetato rosa translúcido. Um clássico feminino em tom pastel.',6,2,11),
('vogue-eyewear-vo5561s','Vogue Eyewear','VO5561S','quadrada','#3a2e22','Acetato',410,'','Quadrada em acetato tartaruga com degradê nas lentes. Fácil de usar todo dia.',6,2,12),
('vogue-eyewear-vo5409s','Vogue Eyewear','VO5409S','quadrada','#9aa3b0','Metal',420,'','Quadrada em metal prateado com lente espelhada. Leve e discreta no rosto.',6,2,13),
('arnette-fastball-20','Arnette','Fastball 2.0','aviador','#141414','Nylon esportivo',380,'Novo','Wraparound esportivo com lente espelhada. Feito pra sol forte e ritmo acelerado.',6,2,14),
('arnette-khim','Arnette','Khim','quadrada','#141414','Nylon esportivo',390,'','Quadrada robusta com lente espelhada azul. Presença forte, sem exagero.',6,2,15),
('arnette-plot-twist','Arnette','Plot Twist','quadrada','#1c2430','Acetato',370,'','Contorno arredondado com lente espelhada. Um clássico despretensioso.',6,2,16),
('arnette-slickster','Arnette','Slickster','quadrada','#141414','Nylon esportivo',380,'','Perfil esportivo com lente espelhada azul. Leve o bastante pro treino, bonito o bastante pra rua.',6,2,17),
('arnette-snap-ii','Arnette','Snap II','aviador','#141414','Nylon esportivo',390,'','Wraparound de proteção lateral ampliada. Feito pra quem não para.',6,2,18),
('kipling-kp4073','Kipling','KP4073','retangular','#6b4226','Acetato',280,'Entrada','Retangular em acetato âmbar translúcido. Leve, colorido e descomplicado.',4,2,19),
('michael-kors-canberra','Michael Kors','Canberra','quadrada','#1a1a1a','Acetato',710,'','Quadrada de traço arredondado com acabamento em degradê. Versátil do consultório ao fim de semana.',5,2,20);
