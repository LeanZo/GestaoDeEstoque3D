PGDMP                         y            TCC_Lucas_Lean    12.3    14.1 C    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    5007168    TCC_Lucas_Lean    DATABASE     p   CREATE DATABASE "TCC_Lucas_Lean" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
     DROP DATABASE "TCC_Lucas_Lean";
                postgres    false                        3079    5007318    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            �           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                        false    2            �            1259    5008320    tbl_armazem    TABLE     �   CREATE TABLE public.tbl_armazem (
    arm_id integer NOT NULL,
    arm_nome character varying,
    arm_pol_id integer,
    arm_ativo boolean
);
    DROP TABLE public.tbl_armazem;
       public         heap    postgres    false            �            1259    5008326    tbl_armazem_arm_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_armazem ALTER COLUMN arm_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_armazem_arm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    208            �            1259    5008328 
   tbl_camada    TABLE     �   CREATE TABLE public.tbl_camada (
    cam_id integer NOT NULL,
    cam_nome character varying,
    cam_cor character varying,
    cam_ativo boolean,
    cam_arm_id integer
);
    DROP TABLE public.tbl_camada;
       public         heap    postgres    false            �            1259    5008334    tbl_camada_cam_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_camada ALTER COLUMN cam_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_camada_cam_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    210            �            1259    5008336    tbl_estante    TABLE     �  CREATE TABLE public.tbl_estante (
    est_id integer NOT NULL,
    est_quantidade_prateleiras integer,
    est_prateleira_largura double precision,
    est_prateleira_altura double precision,
    est_prateleira_profundidade double precision,
    est_prateleira_peso_maximo double precision,
    est_pol_id integer,
    est_usu_id integer,
    est_ativo boolean,
    est_arm_id integer,
    est_ancoragem_lat double precision,
    est_ancoragem_lng double precision
);
    DROP TABLE public.tbl_estante;
       public         heap    postgres    false            �            1259    5008339    tbl_estante_est_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_estante ALTER COLUMN est_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_estante_est_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    212            �            1259    5896201    tbl_item_estoque    TABLE     U  CREATE TABLE public.tbl_item_estoque (
    ite_id integer NOT NULL,
    ite_usu_id integer,
    ite_data_hora timestamp without time zone,
    ite_ativo boolean,
    ite_tie_id integer,
    ite_pack_x double precision,
    ite_pack_y double precision,
    ite_pack_z double precision,
    ite_pra_id integer,
    ite_item_base_id integer
);
 $   DROP TABLE public.tbl_item_estoque;
       public         heap    postgres    false            �            1259    5896199    tbl_item_estoque_ite_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_item_estoque ALTER COLUMN ite_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_item_estoque_ite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    225            �            1259    5008341    tbl_poligono    TABLE       CREATE TABLE public.tbl_poligono (
    pol_id integer NOT NULL,
    pol_cam_id integer,
    pol_geometria public.geometry GENERATED ALWAYS AS (public.st_geomfromgeojson(((pol_geojson)::json ->> 'geometry'::text))) STORED,
    pol_geojson character varying,
    pol_ativo boolean
);
     DROP TABLE public.tbl_poligono;
       public         heap    postgres    false    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2            �            1259    5008348    tbl_poligono_pol_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_poligono ALTER COLUMN pol_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_poligono_pol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214            �            1259    26992930    tbl_prateleira    TABLE     s   CREATE TABLE public.tbl_prateleira (
    pra_id integer NOT NULL,
    pra_est_id integer,
    pra_nivel integer
);
 "   DROP TABLE public.tbl_prateleira;
       public         heap    postgres    false            �            1259    26992928    tbl_prateleira_pra_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_prateleira ALTER COLUMN pra_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_prateleira_pra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    227            �            1259    5008350    tbl_sistema_configuracao    TABLE     �   CREATE TABLE public.tbl_sistema_configuracao (
    sic_id integer NOT NULL,
    sic_nome character varying,
    sic_valor character varying,
    sic_ativo boolean
);
 ,   DROP TABLE public.tbl_sistema_configuracao;
       public         heap    postgres    false            �            1259    5008356 #   tbl_sistema_configuracao_sic_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_sistema_configuracao ALTER COLUMN sic_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_sistema_configuracao_sic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            �            1259    5896186    tbl_tipo_item_estoque    TABLE     �  CREATE TABLE public.tbl_tipo_item_estoque (
    tie_id integer NOT NULL,
    tie_nome character varying,
    tie_descricao character varying,
    tie_largura double precision,
    tie_altura double precision,
    tie_profundidade double precision,
    tie_peso double precision,
    tie_peso_maximo_empilhamento double precision,
    tie_codigo_de_barras character varying,
    tie_usu_id integer,
    tie_data_hora timestamp without time zone,
    tie_ativo boolean
);
 )   DROP TABLE public.tbl_tipo_item_estoque;
       public         heap    postgres    false            �            1259    5896184     tbl_tipo_item_estoque_tie_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_tipo_item_estoque ALTER COLUMN tie_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_tipo_item_estoque_tie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    223            �            1259    5008358    tbl_tipo_usuario    TABLE     }   CREATE TABLE public.tbl_tipo_usuario (
    tpu_id integer NOT NULL,
    tpu_nome character varying,
    tpu_ativo boolean
);
 $   DROP TABLE public.tbl_tipo_usuario;
       public         heap    postgres    false            �            1259    5008364    tbl_tipo_usuario_tpu_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_tipo_usuario ALTER COLUMN tpu_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_tipo_usuario_tpu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    5008366    tbl_usuario    TABLE     �   CREATE TABLE public.tbl_usuario (
    usu_id integer NOT NULL,
    usu_nome character varying,
    usu_senha character varying,
    usu_tpu_id integer,
    usu_ativo boolean
);
    DROP TABLE public.tbl_usuario;
       public         heap    postgres    false            �            1259    5008372    tbl_usuario_usu_id_seq    SEQUENCE     �   ALTER TABLE public.tbl_usuario ALTER COLUMN usu_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_usuario_usu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220                      0    5007623    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    204   �X       �          0    5008320    tbl_armazem 
   TABLE DATA           N   COPY public.tbl_armazem (arm_id, arm_nome, arm_pol_id, arm_ativo) FROM stdin;
    public          postgres    false    208   �X       �          0    5008328 
   tbl_camada 
   TABLE DATA           V   COPY public.tbl_camada (cam_id, cam_nome, cam_cor, cam_ativo, cam_arm_id) FROM stdin;
    public          postgres    false    210   �X       �          0    5008336    tbl_estante 
   TABLE DATA             COPY public.tbl_estante (est_id, est_quantidade_prateleiras, est_prateleira_largura, est_prateleira_altura, est_prateleira_profundidade, est_prateleira_peso_maximo, est_pol_id, est_usu_id, est_ativo, est_arm_id, est_ancoragem_lat, est_ancoragem_lng) FROM stdin;
    public          postgres    false    212   KY       �          0    5896201    tbl_item_estoque 
   TABLE DATA           �   COPY public.tbl_item_estoque (ite_id, ite_usu_id, ite_data_hora, ite_ativo, ite_tie_id, ite_pack_x, ite_pack_y, ite_pack_z, ite_pra_id, ite_item_base_id) FROM stdin;
    public          postgres    false    225   }Z       �          0    5008341    tbl_poligono 
   TABLE DATA           R   COPY public.tbl_poligono (pol_id, pol_cam_id, pol_geojson, pol_ativo) FROM stdin;
    public          postgres    false    214   �\       �          0    26992930    tbl_prateleira 
   TABLE DATA           G   COPY public.tbl_prateleira (pra_id, pra_est_id, pra_nivel) FROM stdin;
    public          postgres    false    227   u       �          0    5008350    tbl_sistema_configuracao 
   TABLE DATA           Z   COPY public.tbl_sistema_configuracao (sic_id, sic_nome, sic_valor, sic_ativo) FROM stdin;
    public          postgres    false    216   su       �          0    5896186    tbl_tipo_item_estoque 
   TABLE DATA           �   COPY public.tbl_tipo_item_estoque (tie_id, tie_nome, tie_descricao, tie_largura, tie_altura, tie_profundidade, tie_peso, tie_peso_maximo_empilhamento, tie_codigo_de_barras, tie_usu_id, tie_data_hora, tie_ativo) FROM stdin;
    public          postgres    false    223   �u       �          0    5008358    tbl_tipo_usuario 
   TABLE DATA           G   COPY public.tbl_tipo_usuario (tpu_id, tpu_nome, tpu_ativo) FROM stdin;
    public          postgres    false    218   �v       �          0    5008366    tbl_usuario 
   TABLE DATA           Y   COPY public.tbl_usuario (usu_id, usu_nome, usu_senha, usu_tpu_id, usu_ativo) FROM stdin;
    public          postgres    false    220   �v       �           0    0    tbl_armazem_arm_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tbl_armazem_arm_id_seq', 1, true);
          public          postgres    false    209            �           0    0    tbl_camada_cam_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tbl_camada_cam_id_seq', 4, true);
          public          postgres    false    211            �           0    0    tbl_estante_est_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.tbl_estante_est_id_seq', 29, true);
          public          postgres    false    213            �           0    0    tbl_item_estoque_ite_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tbl_item_estoque_ite_id_seq', 331, true);
          public          postgres    false    224            �           0    0    tbl_poligono_pol_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.tbl_poligono_pol_id_seq', 96, true);
          public          postgres    false    215            �           0    0    tbl_prateleira_pra_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.tbl_prateleira_pra_id_seq', 19, true);
          public          postgres    false    226            �           0    0 #   tbl_sistema_configuracao_sic_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.tbl_sistema_configuracao_sic_id_seq', 2, true);
          public          postgres    false    217            �           0    0     tbl_tipo_item_estoque_tie_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.tbl_tipo_item_estoque_tie_id_seq', 4, true);
          public          postgres    false    222            �           0    0    tbl_tipo_usuario_tpu_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.tbl_tipo_usuario_tpu_id_seq', 1, false);
          public          postgres    false    219            �           0    0    tbl_usuario_usu_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.tbl_usuario_usu_id_seq', 1, false);
          public          postgres    false    221                       2606    5008375    tbl_armazem tbl_armazem_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tbl_armazem
    ADD CONSTRAINT tbl_armazem_pkey PRIMARY KEY (arm_id);
 F   ALTER TABLE ONLY public.tbl_armazem DROP CONSTRAINT tbl_armazem_pkey;
       public            postgres    false    208                       2606    5008377    tbl_camada tbl_camada_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.tbl_camada
    ADD CONSTRAINT tbl_camada_pkey PRIMARY KEY (cam_id);
 D   ALTER TABLE ONLY public.tbl_camada DROP CONSTRAINT tbl_camada_pkey;
       public            postgres    false    210                       2606    5008379    tbl_estante tbl_estante_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tbl_estante
    ADD CONSTRAINT tbl_estante_pkey PRIMARY KEY (est_id);
 F   ALTER TABLE ONLY public.tbl_estante DROP CONSTRAINT tbl_estante_pkey;
       public            postgres    false    212            %           2606    5896205 &   tbl_item_estoque tbl_item_estoque_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.tbl_item_estoque
    ADD CONSTRAINT tbl_item_estoque_pkey PRIMARY KEY (ite_id);
 P   ALTER TABLE ONLY public.tbl_item_estoque DROP CONSTRAINT tbl_item_estoque_pkey;
       public            postgres    false    225                       2606    5008381    tbl_poligono tbl_poligono_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tbl_poligono
    ADD CONSTRAINT tbl_poligono_pkey PRIMARY KEY (pol_id);
 H   ALTER TABLE ONLY public.tbl_poligono DROP CONSTRAINT tbl_poligono_pkey;
       public            postgres    false    214            '           2606    26992934 "   tbl_prateleira tbl_prateleira_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.tbl_prateleira
    ADD CONSTRAINT tbl_prateleira_pkey PRIMARY KEY (pra_id);
 L   ALTER TABLE ONLY public.tbl_prateleira DROP CONSTRAINT tbl_prateleira_pkey;
       public            postgres    false    227                       2606    5008383 6   tbl_sistema_configuracao tbl_sistema_configuracao_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.tbl_sistema_configuracao
    ADD CONSTRAINT tbl_sistema_configuracao_pkey PRIMARY KEY (sic_id);
 `   ALTER TABLE ONLY public.tbl_sistema_configuracao DROP CONSTRAINT tbl_sistema_configuracao_pkey;
       public            postgres    false    216            #           2606    5896193 0   tbl_tipo_item_estoque tbl_tipo_item_estoque_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.tbl_tipo_item_estoque
    ADD CONSTRAINT tbl_tipo_item_estoque_pkey PRIMARY KEY (tie_id);
 Z   ALTER TABLE ONLY public.tbl_tipo_item_estoque DROP CONSTRAINT tbl_tipo_item_estoque_pkey;
       public            postgres    false    223                       2606    5008385 &   tbl_tipo_usuario tbl_tipo_usuario_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.tbl_tipo_usuario
    ADD CONSTRAINT tbl_tipo_usuario_pkey PRIMARY KEY (tpu_id);
 P   ALTER TABLE ONLY public.tbl_tipo_usuario DROP CONSTRAINT tbl_tipo_usuario_pkey;
       public            postgres    false    218            !           2606    5008387    tbl_usuario tbl_usuario_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_pkey PRIMARY KEY (usu_id);
 F   ALTER TABLE ONLY public.tbl_usuario DROP CONSTRAINT tbl_usuario_pkey;
       public            postgres    false    220            (           2606    5008388 '   tbl_armazem tbl_armazem_arm_pol_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_armazem
    ADD CONSTRAINT tbl_armazem_arm_pol_id_fkey FOREIGN KEY (arm_pol_id) REFERENCES public.tbl_poligono(pol_id);
 Q   ALTER TABLE ONLY public.tbl_armazem DROP CONSTRAINT tbl_armazem_arm_pol_id_fkey;
       public          postgres    false    214    3611    208            )           2606    5008393 '   tbl_estante tbl_estante_est_pol_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_estante
    ADD CONSTRAINT tbl_estante_est_pol_id_fkey FOREIGN KEY (est_pol_id) REFERENCES public.tbl_poligono(pol_id);
 Q   ALTER TABLE ONLY public.tbl_estante DROP CONSTRAINT tbl_estante_est_pol_id_fkey;
       public          postgres    false    212    214    3611            *           2606    5008398 '   tbl_estante tbl_estante_est_usu_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_estante
    ADD CONSTRAINT tbl_estante_est_usu_id_fkey FOREIGN KEY (est_usu_id) REFERENCES public.tbl_usuario(usu_id);
 Q   ALTER TABLE ONLY public.tbl_estante DROP CONSTRAINT tbl_estante_est_usu_id_fkey;
       public          postgres    false    212    220    3617            /           2606    26993376 1   tbl_item_estoque tbl_item_estoque_ite_pra_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_item_estoque
    ADD CONSTRAINT tbl_item_estoque_ite_pra_id_fkey FOREIGN KEY (ite_pra_id) REFERENCES public.tbl_prateleira(pra_id) NOT VALID;
 [   ALTER TABLE ONLY public.tbl_item_estoque DROP CONSTRAINT tbl_item_estoque_ite_pra_id_fkey;
       public          postgres    false    3623    227    225            0           2606    10296299 1   tbl_item_estoque tbl_item_estoque_ite_tie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_item_estoque
    ADD CONSTRAINT tbl_item_estoque_ite_tie_id_fkey FOREIGN KEY (ite_tie_id) REFERENCES public.tbl_tipo_item_estoque(tie_id);
 [   ALTER TABLE ONLY public.tbl_item_estoque DROP CONSTRAINT tbl_item_estoque_ite_tie_id_fkey;
       public          postgres    false    225    223    3619            .           2606    5896206 1   tbl_item_estoque tbl_item_estoque_ite_usu_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_item_estoque
    ADD CONSTRAINT tbl_item_estoque_ite_usu_id_fkey FOREIGN KEY (ite_usu_id) REFERENCES public.tbl_usuario(usu_id);
 [   ALTER TABLE ONLY public.tbl_item_estoque DROP CONSTRAINT tbl_item_estoque_ite_usu_id_fkey;
       public          postgres    false    220    225    3617            +           2606    5008403 )   tbl_poligono tbl_poligono_pol_cam_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_poligono
    ADD CONSTRAINT tbl_poligono_pol_cam_id_fkey FOREIGN KEY (pol_cam_id) REFERENCES public.tbl_camada(cam_id);
 S   ALTER TABLE ONLY public.tbl_poligono DROP CONSTRAINT tbl_poligono_pol_cam_id_fkey;
       public          postgres    false    3607    214    210            1           2606    26992935 -   tbl_prateleira tbl_prateleira_pra_est_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_prateleira
    ADD CONSTRAINT tbl_prateleira_pra_est_id_fkey FOREIGN KEY (pra_est_id) REFERENCES public.tbl_estante(est_id);
 W   ALTER TABLE ONLY public.tbl_prateleira DROP CONSTRAINT tbl_prateleira_pra_est_id_fkey;
       public          postgres    false    227    3609    212            -           2606    5896194 ;   tbl_tipo_item_estoque tbl_tipo_item_estoque_tie_usu_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_tipo_item_estoque
    ADD CONSTRAINT tbl_tipo_item_estoque_tie_usu_id_fkey FOREIGN KEY (tie_usu_id) REFERENCES public.tbl_usuario(usu_id);
 e   ALTER TABLE ONLY public.tbl_tipo_item_estoque DROP CONSTRAINT tbl_tipo_item_estoque_tie_usu_id_fkey;
       public          postgres    false    223    220    3617            ,           2606    5008408 '   tbl_usuario tbl_usuario_usu_tpu_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_usu_tpu_id_fkey FOREIGN KEY (usu_tpu_id) REFERENCES public.tbl_tipo_usuario(tpu_id);
 Q   ALTER TABLE ONLY public.tbl_usuario DROP CONSTRAINT tbl_usuario_usu_tpu_id_fkey;
       public          postgres    false    3615    218    220                  x������ � �      �      x�3�t,�M�:�2W���Ȕ��+F��� U!�      �   \   x�3�t,�M�:�2�S���<%5���Ӑ˘�)1'���|N�ԤTSc���kqIb^Ij1Hqj��%X؄�9��(5%�,�dh�������� ~��      �   "  x�]Rɑ�0|�\F�)P����_��rY�M��� ��O��@�x�Pmǻ1hŨ2r�@��$$S��lA;f������㈑'+~F:����x!�;����(���E����Qtab��uT��)�Z�l���"0m���Q	���xi���8�*i�D~�Ҳl9%�*Q��3�qZ֎(�Q��I亳�͍�:�E嫈Ah:��\\�vJqc1��z�Ӕp9i�˴��?E�i+5Lu^Վ$Gp�Ym.��m)��&N]I����譵?���      �   !  x�m�۵�0E�Ii�j�-�EL����` �D+|����̝��?#�����`��i��цǏ�w)_�: �-���A��ddF�@�@��[c�s_�����-�n*j��;�ٜ�ZY.���/FwN�אC3�)���Kk�A(O	oL�c���kA>0K��!k�ϔ'�IVf�c��F��y��`��nt��I*�2k?��h�S�.kG�@)���Q�*kGD �Id85YK"a��S��(��hmy�H�(�yt�(ӷ�rE�B{���?f���S�����".z���@�T	Q@S7[���
k@=ӵu�\P�����{�c:�-�Něq�#������(�@{��k	'�JF�IncW��1���Ӊ�0�D�ꞈ��1}C��v���:~/�X@����(�7�f�{. ��N�b-���)G�+����B^��^2�ќ\d�n.&��ay	P�km��q�I,
��q�y���J���\P/!��ps��z������O�94o���y2T0��+F�ǧ��~��z��~      �      x��]ͮ9n^�O���� ��H�.3� � @��^�N�����8�Π�&�<ǼXH�H����[7]���9���KR)9�W����|����o�}���}�����<���������_�|��7���/~����?� ?�I�?��������_���O��?��˻�_D�ׇ7?���/�ѧ̗��~���ԟ?}��Ç�����~��wos����6��:|��e���/��ѣ���W�������x�7�m>�"��o�ziZ��=��mk8J@�c���5���Y��*�5�X�ߤS۶We�x�#�o%�d�^���/�=��ٵ5KG��4	ڳ�T��������s�i���1�ߦ-�=��4�
\���,�M��-��Xh]�}�)��l�W+�e���^�����N�*L�_4�\�������*�.[��[��z�_����y��
�,8[����������G�V�lt;�g�e���x��?���?�`DU��M�guԗvR3P�������f��i��3�چ
ޤ���b�	����Y?�Э�����4e��Y���I��㗛�I��!S�FxT��ZOҭj�p�{�y�𖂗ѪL��~��o��O�cP7���L�%rh��/>���*�m����+=Q�[��O�?�����G��?���߾|����ۦ����c�l�@�����C�@4Z��5���4�+��B/���ezHReq;j� �����u��'P�
���a,�4��>���[��P^2��a �? ����~>���N�zpҿ4V7m��ӝ��9^ �,ğ6���aע\�ɿ�o�^��0�t��2v]rߝ��C��Q�Lw���ږh|�Y�~x�~�Dq�U��e֨q���9��M=�1��4l5$�E� T�BJ�C."�Pv�Z�5��p��h!5Y����D@pTZ�Ii���(N�j	@O4UP�%���|RIҰ� ��'��m�QcA #C	b�v�D�j5�P�-D_;k\r�A�i-7\P�=�'f
@�V��	��R�,�R@�>��H���7�oS����ҜJ���j��j]#Pzncĩ�D�R�<�06�^缉��i��n��pM��e؊�/�[�;� ���L��xF���2i|p��-WCD�k�ʜ��Lh2[ǘ�4C�l���FT���k�nH�����,ˤb�9��� GR���Dj������f��2#�i���b��Ok��2-��*',`@GDG �����z߀D	��H9�������aC����i�<�w��a�N;���@(��jts#j�&n`���z(RC#aeoT%[tt�[���qΤ�d���~� m�cJw򶼠\��f/tg����n��Yv��q�9�
�Iߒ�Ǉ7�7�b]��Y��QT�E������/�#�l�WA��PQ��zk�4PܲY��
��66��1�S���S��ҋf~��|(5�^�U����?�1x(�����r�
�����_��������)5���3W��L��y�1g��ڲ6n��!e(TCԕ����W��
z��ϻט��s��~6�0����%�>Fs�{�}���m�#����hC@� FVgE�lVT̬Zz�j� )�!=��=��2]�𥉉��Ǥp�an�\5�7$��-�z%m�Ѵ�5��7�[:�h�m�^&���7�H�Ⱦ��:vY�%����J)�����I�|k~�薲�-������.|>х�6�
�G�7��uw�4R\F����EECq�0#ǎ/�z~����Ɩ����T�3��JS���1��Р`^H+y��0p�i�B�b����un�|�B:�A�ܸc@�d�R�=�'�G3B�Ⱦ�W�)�F6�#�$zr!�SC�dc��r6"8��Dhq�M}h��-�-4�{�i�^w�%�������ZN��D�*�J�b�W)�{T���� �]%J�`�)M�J�$^@�%o��A�eG��e�V�!���i4�� X��0l/o�}��(%r�aQ�.���!@�o9R����9=�Dh�ZO�.�^�;�LK˺B��(�BJ�eG��)Q���-ۇ��*e�09m���5Cz�2b������-\�� ���S^S��9�J��~��F{�M�,�S,�m.�"3 �[�ʜ��g�C�)�|����( ���8�*[�Y�	,���pHtM��m.P��M�kd%OE���� 4�g�r����*2u����Eji���:utuQ��NPkj��B��P4�|��v
R�T�H�=2%�\$5+�<|Qb�X&`�W��1��ʐa��I��B��I�gY��77"�PB�a_��ȳ80�26�Ă"�(4��:�{ѩ�C�k��B1`a�P� �T%�О��a=S��Ϣg�@Te����\!���k4г#R1�ފ�b�B�n��LB9-*�zx��l����ff���u���(u4��%.>IJɎ䵤E��n�}���5IV������em�fU��As�%`v�,M#:�}[����Т�)�n�^����G�ƌ�)R�C�t/z @�ֽ��5GӈVJ^��_#�y�sM���{�E�Y�P[��hb�.c�8�t�[I����译E��#8bH�5��ϙIk?)k��jD-3-��{z�e�Հ{I}7���N�r�؛��H�@`�i���_�ZI���G'I{h��z5j��w�o����4qJ��(^G��V�9�j;;�G�d�eۣ���D
أ5��E�xo7��{��[��o�9�g���^ɐ);�.Z�\'�Ewo�O�̧�c*�u��Y���6OV��Cn
��4�?HQ�iӚW@Én+��x���-I^����4�yF_w�ol��F��T�]�Ph������\��sfRsJg/���e�dW��q��Fb�� ՛)P���:�u\�/J�����Qf�3#��C���Cb�Đ�M$oF�|��������<���y9�}�����k��x)�њ��.3Z���x �O��g'�=�Q[���J�9Gnc;�__�l[OO��?��?���j�Pɼ�ڰG\�*���5#�x|���ζnd�<RB�
��M����_:|�ҩ3f� Cq�[��l��g��|�I�`���a83�ӷ4ӝw���!>���8�O3uR�Gy����T
tjh�b��8Ś��tZ�li9 ++�t�l���2���hgQ�쪝s�T�/�.�+?l�<8�^j<Ґ����(��I�jVS��OKiqn#�`��3/f�1.��;��͊u��fGw�j{_�{���LZ�x�a����+Hj��9Ie�[wJof'/���u.�\��1l�k5����?I}q${�N��J�}؀xQNcg�@���E%��"W��
�dFl֟"��&����4췈��b}L�G
7�b8�ft� 9���c�Q��&0j!��F�J8 9�$#�X���荀�-R�nL�K
�CU��?J���3O;��r�[�F0��2�Gt_Tʊ�L9��$�)��!��xlo@����U�,�Xa�Z@���g T�oY���#Kټ��ִ�3G^�c5�"�#>'h���������W����k���5"?I�Z^H�O3;w��]=��]B�;�C8[2�ّ̾&pl��� sm!P�ϡ���[�d� C�9R�/���!ݭV����S�t/+��QC���q��܈�J�^i]�>��:�X�8����Z�%YT�+�N�Xu�E�D�ّ��P�:�~̑��Z���攂O�H��%���H�}���*F���u\3@&k������C��#E�۟�ҙ�ic9LBc��J�΀j��>2�_-���6{z�m�kA@��##Y�,d�M���4�d�<�9����LD���g�i�;�9A4jT)�������&M���R�#�U��R]��*���$��c���x�PJ=,ϸ̟�4��a�58f�!��ž�q�Եԡf�7����~;��EQ=goN8���zJ� ��"�!-X8�h�\g�$ �3��<fu��Z׹Xt����]!�ğfF����z���=<��f�w�~Q� W  v��ב�4��=>O��yB[�i���/-�M�W�!��3��s�����b_m��{^tmO��9��KX9n�/ow84�����.&ӝw�iюg����QqӜ�4u*�#�KxCOo�����O�:ef�c�o�s"`�-�c��N1/� ��#t[>�ew�Ӱ���}�P���s��x�my���\�l�.�-�!	3��;|[.~�M%���Eb�����?᳞��6�K�u�u ɶ�ot^�6���i��M��=ٺl��(� cq�_�+��
HŲӈZ.r���������{�63Q�3'l����(�i��(;N,���eR�,�{*:����ِr�!��h�m�UZ��.�|�9��!�w��w��%O��ɼ��ٌなvv����jy���B���v���yXn.�A��!ǹ�v6�&�I��3w^o����t���v�Y�_�1�[���Y��~cY��s|0�ك��^��� �2g�q�����?��]��!�����	n�l�ُ~���� n�O��Q�z���~��x|q<���q'���$>b9�i�?n��l�w������d��@Md&H�	�`t�{r766҆Ȗ=nH~lpFf�V���ĳM���d�#f��J`?� �xE`�`�p�p޺�.��!J�6㬹'�@�3`/~���`��p?�V��p�p�a���?�3��KG�f�dʼ-��Q&�Z:����R��>+��
6@�2���,�?�(�'�(2��Ď����D�vď[�Q�,R�e�92Q�d �!C�S�Ar�Y�)���kJ���,�uOC�7�Xj�u! �=�����C�(���N`=��c�U�)�ب�qv/ lͩR�x�aM�d��~���:�=s@�(�G�������*ʓ�X�)a�"ո�ʢ�H�ٟ-�x�̴n)(9��t*Z�J�#�a�{6+�@&Q���n��oVlɎ����x�d�ev�g�B�ƼB�QF&�Dh������F�(�N�K'�L�#�ڥ�hWe�j��P=�Q�ڬt�^oQ��J��S2=�ՠwO��/�,�C;��Q�XP�u�p ��
���UU&v�g�������E�Fv���^H����.n�4c�U�_�>+�M,i��k�.�7|&�aQ�� ���KA�-=ʔ2�F)��́@��ߏ��-�J�\����Ք�\K�if)I&D�NN��h�s�i4bH�AFz�j x6S4G�H�,%������,%'�6R�R�����,%��iQ���d�-LAј�p&�'�1K��8<%��0��r�@S��-�A��j��S���d�q^p�[de�E����T2�h����vp;�ŉ���P�(��ȦF/���9�$k!��+�U�1��5�R��L���0���0[���p|�����\	>�Xv��U>�eJ�u�z��s�Y�E�
v/�L* ͎N+{��L���#�( ���Ҙ`����١�lQ��-��(�4����DD#̪	�)�d��Q^�r�)v @,@��j�]9��L�Ջ�e���,��Q�K1�%�Q󔑮�e(Y�Oţ����U� ʰ�s�L����Șm'
����q�倣�}���e�jb���D��K&��e �����Q-WU�>�"�ց��ڏo���[��>\!#Zoj����eOX�t���M=>q{���l��Tۇ��������N��8?G��sq+�ueV�X���=[��ϩ�dN�(�ke��qn���S�u� �c�A�uߜ�VF��Ε�)ǹ@<�|j���߄!���Dd��hx~����a":�� ��.ݥ�;��%�09f�����yʄB�����o�ǡ9���[T@�;2�)>S�q��@|�S��Ym8��`N5{e΅���Y�О�����Ǒ�4��ctv��I8r��!r�'2�x<�@�C,�q�e�{��2�x\���Z����6�ОpDX,h|�Wht�B{Lc뉙�t�b	Q�<��Hgg&�.%�Q.�Le���E�����~�c 2����;��ii��k6��n���-ܵzn�#)A�Fylt�,�]]��G=����?1�;��M�'�<�sdܽ��!�{��(��Y���	]�[�}{����a�\      �   I   x����0�0LUpZ%�t�9
�t:�h�R��>P_(���y���]�Q�V���2������.�?c2       �   Y   x�3�,K-*N��4�3�,�2�LJ�IN��M�K�/JLO���I,��K�V2��t��,M��Lu���@##=KcK�`-А=... ���      �   �   x�e�;�0@g��@��q��X`h�n�HLH�7b� ��ZT!b9q,����A��G�L��b�-���e�@��A�`��$҉X��=�!��<ʮ=�C{�~�8]��彼�h�W�3�"H�����h�D�]BTlXǂ7�e9 ��Q��7T�\n�a�>el��\!U���C!�1Y��S�gMq��N�>)      �      x������ � �      �      x������ � �     