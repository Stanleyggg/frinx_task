--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: interfaces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interfaces (
    id integer NOT NULL,
    connection integer,
    name character varying(255) NOT NULL,
    description character varying(255),
    config json,
    type character varying(50),
    infra_type character varying(50),
    port_channel_id integer,
    max_frame_size integer
);


ALTER TABLE public.interfaces OWNER TO postgres;

--
-- Name: interfaces_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.interfaces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interfaces_id_seq OWNER TO postgres;

--
-- Name: interfaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.interfaces_id_seq OWNED BY public.interfaces.id;


--
-- Name: interfaces id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interfaces ALTER COLUMN id SET DEFAULT nextval('public.interfaces_id_seq'::regclass);


--
-- Data for Name: interfaces; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interfaces (id, connection, name, description, config, type, infra_type, port_channel_id, max_frame_size) FROM stdin;
1	\N	Port-channel20	InternetPro-123.321.123	{"name": 20, "description": "InternetPro-123.321.123", "Cisco-IOS-XE-ethernet:service": {"instance": [{"id": 102, "l2protocol": {"peer": {"protocol": ["lacp"]}, "tunnel": {"protocol": ["stp"]}}, "bridge-domain": {"bridge-id": 102}, "ethernet-evc-name": "CI_VLAN112233", "encapsulation": {"untagged": {}}, "ethernet": [null]}]}, "storm-control": {"broadcast": {"level": {"threshold": {"rising-threshold": 10}}}, "unicast": {"level": {"threshold": {"rising-threshold": 10}}}}, "mtu": 9216, "Cisco-IOS-XE-policy:service-policy": {"input": "PM_UNI_ASSURED_200M_IN"}}	\N	\N	\N	9216
2	\N	Port-channel5	None	{"name": 5, "Cisco-IOS-XE-ethernet:negotiation": {"auto": false}, "Cisco-IOS-XE-ethernet:service": {"instance": [{"id": 1, "encapsulation": {"dot1q": {"id": [6, 1405]}}, "trunk": [null], "ethernet": [null]}]}}	\N	\N	\N	\N
3	\N	TenGigabitEthernet0/0/5	member of Portchannel20	{"name": "0/0/5", "description": "member of Portchannel20", "keepalive": false, "Cisco-IOS-XE-ethernet:channel-group": {"number": 20, "mode": "active"}, "mtu": 9216}	\N	\N	1	9216
4	\N	TenGigabitEthernet0/0/2	InternetPro-111.333.999 Client name	{"name": "0/0/2", "description": "InternetPro-111.333.999 Client name", "keepalive": false, "Cisco-IOS-XE-ethernet:service": {"instance": [{"id": 103, "l2protocol": {"tunnel": {"protocol": ["stp"]}}, "bridge-domain": {"bridge-id": 103, "split-horizon": {"group": 3}}, "ethernet-evc-name": "CI_VLAN113399", "encapsulation": {"untagged": {}}, "ethernet": [null]}]}, "Cisco-IOS-XE-lldp:lldp": {"receive": false, "transmit": false}, "Cisco-IOS-XE-policy:service-policy": {"input": "PM_UNI_ASSURED_200Mb"}}	\N	\N	\N	\N
5	\N	TenGigabitEthernet0/0/3	Uplink to ED5 / 11	{"name": "0/0/3", "description": "Uplink to ED5 / 11", "Cisco-IOS-XE-ethernet:service": {"instance": [{"id": 4000, "description": "For untagged packets (LLDP) test", "l2protocol": {"peer": {"protocol": ["lldp"]}}, "bridge-domain": {"bridge-id": 4000}, "encapsulation": {"untagged": {}}, "ethernet": [null]}, {"id": 1, "bridge-domain": {"from-encapsulation": [null]}, "encapsulation": {"dot1q": {"id": [3131, 1176, 1199, 1102, 1405, 6, 2102]}}, "trunk": [null], "ethernet": [null], "rewrite": {"ingress": {"tag": {"pop": {"way": "1", "mode": "symmetric"}}}}}]}, "mtu": 9216, "Cisco-IOS-XE-policy:service-policy": {"input": "PM-ASSURED-IN", "output": "PM-NNI-100M-OUT"}}	\N	\N	\N	9216
6	\N	TenGigabitEthernet0/0/4	member of Portchannel20	{"name": "0/0/4", "description": "member of Portchannel20", "keepalive": false, "Cisco-IOS-XE-ethernet:channel-group": {"number": 20, "mode": "active"}, "mtu": 9216}	\N	\N	1	9216
7	\N	GigabitEthernet0/0/1	InternetPro-123.456.789 - Client name	{"name": "0/0/1", "description": "InternetPro-123.456.789 - Client name", "keepalive": false, "media-type": "rj45", "Cisco-IOS-XE-lldp:lldp": {"receive": false, "transmit": false}, "Cisco-IOS-XE-policy:service-policy": {"input": "PM_UNI_ASSURED_PIN_200Mb"}, "Cisco-IOS-XE-ethernet:negotiation": {"auto": true}, "Cisco-IOS-XE-ethernet:service": {"instance": [{"id": 101, "l2protocol": {"tunnel": {"protocol": ["stp"]}}, "bridge-domain": {"bridge-id": 101, "split-horizon": {"group": 3}}, "ethernet-evc-name": "CI_VLAN123456", "encapsulation": {"untagged": {}}, "ethernet": [null]}]}}	\N	\N	\N	\N
8	\N	GigabitEthernet0	None	{"name": "0", "Cisco-IOS-XE-ethernet:negotiation": {"auto": true}, "vrf": {"forwarding": "Mgmt-intf"}, "ip": {"address": {"primary": {"address": "172.16.1.56", "mask": "255.255.254.0"}}}}	\N	\N	\N	\N
9	\N	GigabitEthernet0/0/0	VLAN372638 FRINX_LAB_IVP	{"name": "0/0/0", "description": "VLAN372638 FRINX_LAB_IVP", "keepalive": false, "media-type": "rj45", "load-interval": 30, "Cisco-IOS-XE-ethernet:negotiation": {"auto": true}, "Cisco-IOS-XE-ethernet:service": {"instance": [{"id": 100, "encapsulation": {"untagged": {}}, "bridge-domain": {"bridge-id": 100}, "ethernet": [null]}]}, "Cisco-IOS-XE-snmp:snmp": {"trap": {"link-status": false}}}	\N	\N	\N	\N
\.


--
-- Name: interfaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.interfaces_id_seq', 9, true);


--
-- Name: interfaces interfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interfaces
    ADD CONSTRAINT interfaces_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

