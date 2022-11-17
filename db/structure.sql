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
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ama_subscribers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ama_subscribers (
    id integer NOT NULL,
    ama_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ama_subscribers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ama_subscribers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ama_subscribers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ama_subscribers_id_seq OWNED BY public.ama_subscribers.id;


--
-- Name: amas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amas (
    id integer NOT NULL,
    author_id integer NOT NULL,
    original_post_id integer NOT NULL,
    ama_subscribers_count integer DEFAULT 0 NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: amas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amas_id_seq OWNED BY public.amas.id;


--
-- Name: anime; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anime (
    id integer NOT NULL,
    slug public.citext,
    age_rating integer,
    episode_count integer,
    episode_length integer,
    youtube_video_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    average_rating numeric(5,2),
    user_count integer DEFAULT 0 NOT NULL,
    age_rating_guide character varying(255),
    subtype integer DEFAULT 1 NOT NULL,
    start_date date,
    end_date date,
    rating_frequencies public.hstore DEFAULT ''::public.hstore NOT NULL,
    cover_image_top_offset integer DEFAULT 0 NOT NULL,
    titles public.hstore DEFAULT ''::public.hstore NOT NULL,
    canonical_title character varying DEFAULT 'en_jp'::character varying NOT NULL,
    abbreviated_titles character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    popularity_rank integer,
    rating_rank integer,
    favorites_count integer DEFAULT 0 NOT NULL,
    cover_image_processing boolean,
    tba character varying,
    episode_count_guess integer,
    total_length integer,
    release_schedule text,
    original_locale character varying,
    description jsonb DEFAULT '{}'::jsonb NOT NULL,
    poster_image_data jsonb,
    cover_image_data jsonb,
    origin_languages character varying[] DEFAULT '{}'::character varying[],
    origin_countries character varying[] DEFAULT '{}'::character varying[]
);


--
-- Name: anime_castings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anime_castings (
    id integer NOT NULL,
    anime_character_id integer NOT NULL,
    person_id integer NOT NULL,
    locale character varying NOT NULL,
    licensor_id integer,
    notes character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: anime_castings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anime_castings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anime_castings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anime_castings_id_seq OWNED BY public.anime_castings.id;


--
-- Name: anime_characters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anime_characters (
    id integer NOT NULL,
    anime_id integer NOT NULL,
    character_id integer NOT NULL,
    role integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: anime_characters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anime_characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anime_characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anime_characters_id_seq OWNED BY public.anime_characters.id;


--
-- Name: anime_genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anime_genres (
    anime_id integer NOT NULL,
    genre_id integer NOT NULL
);


--
-- Name: anime_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anime_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anime_id_seq OWNED BY public.anime.id;


--
-- Name: anime_media_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anime_media_attributes (
    id integer NOT NULL,
    anime_id integer NOT NULL,
    media_attribute_id integer NOT NULL,
    high_vote_count integer DEFAULT 0 NOT NULL,
    neutral_vote_count integer DEFAULT 0 NOT NULL,
    low_vote_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: anime_media_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anime_media_attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anime_media_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anime_media_attributes_id_seq OWNED BY public.anime_media_attributes.id;


--
-- Name: anime_productions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anime_productions (
    id integer NOT NULL,
    anime_id integer NOT NULL,
    producer_id integer NOT NULL,
    role integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: anime_productions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anime_productions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anime_productions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anime_productions_id_seq OWNED BY public.anime_productions.id;


--
-- Name: anime_staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anime_staff (
    id integer NOT NULL,
    anime_id integer NOT NULL,
    person_id integer NOT NULL,
    role character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: anime_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anime_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anime_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anime_staff_id_seq OWNED BY public.anime_staff.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: blocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blocks (
    id integer NOT NULL,
    user_id integer NOT NULL,
    blocked_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blocks_id_seq OWNED BY public.blocks.id;


--
-- Name: castings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.castings (
    id integer NOT NULL,
    media_id integer NOT NULL,
    person_id integer,
    character_id integer,
    role character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    voice_actor boolean DEFAULT false NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    "order" integer,
    language character varying(255),
    media_type character varying(255) NOT NULL
);


--
-- Name: castings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.castings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: castings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.castings_id_seq OWNED BY public.castings.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    title character varying NOT NULL,
    slug public.citext NOT NULL,
    anidb_id integer,
    parent_id integer,
    total_media_count integer DEFAULT 0 NOT NULL,
    nsfw boolean DEFAULT false NOT NULL,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    child_count integer DEFAULT 0 NOT NULL,
    description jsonb DEFAULT '{}'::jsonb NOT NULL,
    ancestry character varying COLLATE pg_catalog."POSIX"
);


--
-- Name: categories_dramas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories_dramas (
    category_id integer NOT NULL,
    drama_id integer NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: category_favorites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category_favorites (
    id integer NOT NULL,
    user_id integer NOT NULL,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: category_favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.category_favorites_id_seq OWNED BY public.category_favorites.id;


--
-- Name: chapters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chapters (
    id integer NOT NULL,
    manga_id integer,
    titles public.hstore DEFAULT ''::public.hstore NOT NULL,
    canonical_title character varying,
    number integer NOT NULL,
    volume_number integer,
    length integer,
    published date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    filler boolean,
    volume_id integer,
    description jsonb DEFAULT '{}'::jsonb NOT NULL,
    thumbnail_data jsonb
);


--
-- Name: chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chapters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chapters_id_seq OWNED BY public.chapters.id;


--
-- Name: character_voices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.character_voices (
    id integer NOT NULL,
    media_character_id integer NOT NULL,
    person_id integer NOT NULL,
    locale character varying NOT NULL,
    licensor_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: character_voices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.character_voices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: character_voices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.character_voices_id_seq OWNED BY public.character_voices.id;


--
-- Name: characters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characters (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mal_id integer,
    slug public.citext,
    primary_media_id integer,
    primary_media_type character varying,
    names jsonb DEFAULT '{}'::jsonb NOT NULL,
    canonical_name character varying NOT NULL,
    other_names character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    description jsonb DEFAULT '{}'::jsonb NOT NULL,
    image_data jsonb
);


--
-- Name: characters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.characters_id_seq OWNED BY public.characters.id;


--
-- Name: comment_likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comment_likes (
    id integer NOT NULL,
    comment_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comment_likes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comment_likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comment_likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comment_likes_id_seq OWNED BY public.comment_likes.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    content text,
    content_formatted text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    blocked boolean DEFAULT false NOT NULL,
    parent_id integer,
    likes_count integer DEFAULT 0 NOT NULL,
    replies_count integer DEFAULT 0 NOT NULL,
    edited_at timestamp without time zone,
    embed jsonb,
    ao_id character varying,
    hidden_at timestamp without time zone
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: community_recommendation_follows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_recommendation_follows (
    id integer NOT NULL,
    user_id integer NOT NULL,
    community_recommendation_request_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: community_recommendation_follows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_recommendation_follows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_recommendation_follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_recommendation_follows_id_seq OWNED BY public.community_recommendation_follows.id;


--
-- Name: community_recommendation_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_recommendation_requests (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: community_recommendation_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_recommendation_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_recommendation_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_recommendation_requests_id_seq OWNED BY public.community_recommendation_requests.id;


--
-- Name: community_recommendations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_recommendations (
    id integer NOT NULL,
    media_id integer,
    media_type character varying,
    anime_id integer,
    drama_id integer,
    manga_id integer,
    community_recommendation_request_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: community_recommendations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_recommendations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_recommendations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_recommendations_id_seq OWNED BY public.community_recommendations.id;


--
-- Name: drama_castings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.drama_castings (
    id integer NOT NULL,
    drama_character_id integer NOT NULL,
    person_id integer NOT NULL,
    locale character varying NOT NULL,
    licensor_id integer,
    notes character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: drama_castings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.drama_castings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drama_castings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.drama_castings_id_seq OWNED BY public.drama_castings.id;


--
-- Name: drama_characters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.drama_characters (
    id integer NOT NULL,
    drama_id integer NOT NULL,
    character_id integer NOT NULL,
    role integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: drama_characters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.drama_characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drama_characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.drama_characters_id_seq OWNED BY public.drama_characters.id;


--
-- Name: drama_staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.drama_staff (
    id integer NOT NULL,
    drama_id integer NOT NULL,
    person_id integer NOT NULL,
    role character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: drama_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.drama_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drama_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.drama_staff_id_seq OWNED BY public.drama_staff.id;


--
-- Name: dramas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dramas (
    id integer NOT NULL,
    slug public.citext NOT NULL,
    titles public.hstore DEFAULT ''::public.hstore NOT NULL,
    canonical_title character varying DEFAULT 'en_jp'::character varying NOT NULL,
    abbreviated_titles character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    age_rating integer,
    age_rating_guide character varying,
    episode_count integer,
    episode_length integer,
    subtype integer,
    start_date date,
    end_date date,
    youtube_video_id character varying,
    country character varying DEFAULT 'ja'::character varying NOT NULL,
    cover_image_top_offset integer DEFAULT 0 NOT NULL,
    average_rating numeric(5,2),
    rating_frequencies public.hstore DEFAULT ''::public.hstore NOT NULL,
    user_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    popularity_rank integer,
    rating_rank integer,
    favorites_count integer DEFAULT 0 NOT NULL,
    cover_image_processing boolean,
    tba character varying,
    total_length integer DEFAULT 0 NOT NULL,
    release_schedule text,
    description jsonb DEFAULT '{}'::jsonb NOT NULL,
    poster_image_data jsonb,
    cover_image_data jsonb,
    origin_languages character varying[] DEFAULT '{}'::character varying[],
    origin_countries character varying[] DEFAULT '{}'::character varying[]
);


--
-- Name: dramas_genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dramas_genres (
    drama_id integer NOT NULL,
    genre_id integer NOT NULL
);


--
-- Name: dramas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dramas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dramas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dramas_id_seq OWNED BY public.dramas.id;


--
-- Name: dramas_media_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dramas_media_attributes (
    id integer NOT NULL,
    drama_id integer NOT NULL,
    media_attribute_id integer NOT NULL,
    high_vote_count integer DEFAULT 0 NOT NULL,
    neutral_vote_count integer DEFAULT 0 NOT NULL,
    low_vote_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: dramas_media_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dramas_media_attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dramas_media_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dramas_media_attributes_id_seq OWNED BY public.dramas_media_attributes.id;


--
-- Name: episodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.episodes (
    id integer NOT NULL,
    media_id integer NOT NULL,
    number integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    season_number integer,
    airdate date,
    length integer,
    titles public.hstore DEFAULT ''::public.hstore NOT NULL,
    canonical_title character varying,
    media_type character varying NOT NULL,
    relative_number integer,
    filler boolean,
    description jsonb DEFAULT '{}'::jsonb NOT NULL,
    thumbnail_data jsonb
);


--
-- Name: episodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.episodes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: episodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.episodes_id_seq OWNED BY public.episodes.id;


--
-- Name: favorite_genres_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favorite_genres_users (
    genre_id integer,
    user_id integer
);


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favorites (
    id integer NOT NULL,
    user_id integer NOT NULL,
    item_id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fav_rank integer
);


--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.follows (
    id integer NOT NULL,
    followed_id integer,
    follower_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    hidden boolean DEFAULT false NOT NULL
);


--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.follows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.follows_id_seq OWNED BY public.follows.id;


--
-- Name: franchises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.franchises (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    titles public.hstore DEFAULT ''::public.hstore NOT NULL,
    canonical_title character varying DEFAULT 'en_jp'::character varying NOT NULL
);


--
-- Name: franchises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.franchises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: franchises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.franchises_id_seq OWNED BY public.franchises.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.friendly_id_slugs (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(40),
    created_at timestamp without time zone
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.friendly_id_slugs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.friendly_id_slugs_id_seq OWNED BY public.friendly_id_slugs.id;


--
-- Name: gallery_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gallery_images (
    id integer NOT NULL,
    anime_id integer,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone
);


--
-- Name: gallery_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gallery_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gallery_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gallery_images_id_seq OWNED BY public.gallery_images.id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    name character varying(255),
    slug public.citext,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: genres_manga; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genres_manga (
    manga_id integer NOT NULL,
    genre_id integer NOT NULL
);


--
-- Name: global_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.global_stats (
    id integer NOT NULL,
    type character varying NOT NULL,
    stats_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: global_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.global_stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: global_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.global_stats_id_seq OWNED BY public.global_stats.id;


--
-- Name: group_action_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_action_logs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    verb character varying NOT NULL,
    target_id integer NOT NULL,
    target_type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


--
-- Name: group_action_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_action_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_action_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_action_logs_id_seq OWNED BY public.group_action_logs.id;


--
-- Name: group_bans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_bans (
    id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    moderator_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    notes text,
    notes_formatted text
);


--
-- Name: group_bans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_bans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_bans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_bans_id_seq OWNED BY public.group_bans.id;


--
-- Name: group_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_categories (
    id integer NOT NULL,
    name character varying NOT NULL,
    slug public.citext NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: group_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_categories_id_seq OWNED BY public.group_categories.id;


--
-- Name: group_invites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_invites (
    id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    sender_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    accepted_at timestamp without time zone,
    declined_at timestamp without time zone
);


--
-- Name: group_invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_invites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_invites_id_seq OWNED BY public.group_invites.id;


--
-- Name: group_member_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_member_notes (
    id integer NOT NULL,
    group_member_id integer NOT NULL,
    user_id integer NOT NULL,
    content text NOT NULL,
    content_formatted text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_member_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_member_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_member_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_member_notes_id_seq OWNED BY public.group_member_notes.id;


--
-- Name: group_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_members (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    rank integer DEFAULT 0 NOT NULL,
    unread_count integer DEFAULT 0 NOT NULL,
    hidden boolean DEFAULT false NOT NULL
);


--
-- Name: group_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_members_id_seq OWNED BY public.group_members.id;


--
-- Name: group_neighbors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_neighbors (
    id integer NOT NULL,
    source_id integer NOT NULL,
    destination_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_neighbors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_neighbors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_neighbors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_neighbors_id_seq OWNED BY public.group_neighbors.id;


--
-- Name: group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_permissions (
    id integer NOT NULL,
    group_member_id integer NOT NULL,
    permission integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_permissions_id_seq OWNED BY public.group_permissions.id;


--
-- Name: group_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_reports (
    id integer NOT NULL,
    explanation text,
    reason integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    naughty_id integer NOT NULL,
    naughty_type character varying NOT NULL,
    moderator_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_reports_id_seq OWNED BY public.group_reports.id;


--
-- Name: group_ticket_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_ticket_messages (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    user_id integer NOT NULL,
    kind integer DEFAULT 0 NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_ticket_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_ticket_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_ticket_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_ticket_messages_id_seq OWNED BY public.group_ticket_messages.id;


--
-- Name: group_tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_tickets (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    assignee_id integer,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_message_id integer
);


--
-- Name: group_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_tickets_id_seq OWNED BY public.group_tickets.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug public.citext NOT NULL,
    about text DEFAULT ''::text NOT NULL,
    members_count integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rules text,
    rules_formatted text,
    nsfw boolean DEFAULT false NOT NULL,
    privacy integer DEFAULT 0 NOT NULL,
    locale character varying,
    tags character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    leaders_count integer DEFAULT 0 NOT NULL,
    neighbors_count integer DEFAULT 0 NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    category_id integer NOT NULL,
    tagline character varying(60),
    last_activity_at timestamp without time zone,
    pinned_post_id integer,
    avatar_data jsonb,
    cover_image_data jsonb
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: hashtags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hashtags (
    id integer NOT NULL,
    name character varying NOT NULL,
    kind integer DEFAULT 0 NOT NULL,
    item_id integer,
    item_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: hashtags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hashtags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hashtags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hashtags_id_seq OWNED BY public.hashtags.id;


--
-- Name: installments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.installments (
    id integer NOT NULL,
    media_id integer,
    franchise_id integer,
    media_type character varying NOT NULL,
    release_order integer,
    tag integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    alternative_order integer
);


--
-- Name: installments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.installments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: installments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.installments_id_seq OWNED BY public.installments.id;


--
-- Name: leader_chat_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leader_chat_messages (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    content text NOT NULL,
    content_formatted text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    edited_at timestamp without time zone
);


--
-- Name: leader_chat_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leader_chat_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leader_chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leader_chat_messages_id_seq OWNED BY public.leader_chat_messages.id;


--
-- Name: library_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.library_entries (
    id integer NOT NULL,
    user_id integer NOT NULL,
    media_id integer NOT NULL,
    status integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    progress integer DEFAULT 0 NOT NULL,
    private boolean DEFAULT false NOT NULL,
    notes text,
    reconsume_count integer DEFAULT 0 NOT NULL,
    reconsuming boolean DEFAULT false NOT NULL,
    media_type character varying NOT NULL,
    volumes_owned integer DEFAULT 0 NOT NULL,
    nsfw boolean DEFAULT false NOT NULL,
    anime_id integer,
    manga_id integer,
    drama_id integer,
    rating integer,
    time_spent integer DEFAULT 0 NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    progressed_at timestamp without time zone,
    media_reaction_id integer,
    reaction_skipped integer DEFAULT 0 NOT NULL
);


--
-- Name: library_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.library_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: library_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.library_entries_id_seq OWNED BY public.library_entries.id;


--
-- Name: library_entry_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.library_entry_logs (
    id integer NOT NULL,
    linked_account_id integer NOT NULL,
    media_type character varying NOT NULL,
    media_id integer NOT NULL,
    progress integer,
    rating integer,
    reconsume_count integer,
    reconsuming boolean,
    status integer,
    volumes_owned integer,
    action_performed character varying DEFAULT 'create'::character varying NOT NULL,
    sync_status integer DEFAULT 0 NOT NULL,
    error_message text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: library_entry_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.library_entry_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: library_entry_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.library_entry_logs_id_seq OWNED BY public.library_entry_logs.id;


--
-- Name: library_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.library_events (
    id integer NOT NULL,
    library_entry_id integer NOT NULL,
    user_id integer NOT NULL,
    anime_id integer,
    manga_id integer,
    drama_id integer,
    kind integer NOT NULL,
    changed_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: library_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.library_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: library_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.library_events_id_seq OWNED BY public.library_events.id;


--
-- Name: linked_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.linked_accounts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    external_user_id character varying NOT NULL,
    share_to boolean DEFAULT false NOT NULL,
    share_from boolean DEFAULT false NOT NULL,
    encrypted_token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    encrypted_token_iv character varying,
    type character varying NOT NULL,
    sync_to boolean DEFAULT false NOT NULL,
    disabled_reason character varying,
    session_data text
);


--
-- Name: linked_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.linked_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: linked_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.linked_accounts_id_seq OWNED BY public.linked_accounts.id;


--
-- Name: list_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.list_imports (
    id integer NOT NULL,
    type character varying NOT NULL,
    user_id integer NOT NULL,
    strategy integer NOT NULL,
    input_file_file_name character varying,
    input_file_content_type character varying,
    input_file_file_size integer,
    input_file_updated_at timestamp without time zone,
    input_text text,
    status integer DEFAULT 0 NOT NULL,
    progress integer,
    total integer,
    error_message text,
    error_trace text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    input_file_data jsonb
);


--
-- Name: list_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.list_imports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: list_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.list_imports_id_seq OWNED BY public.list_imports.id;


--
-- Name: manga; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manga (
    id integer NOT NULL,
    slug public.citext,
    start_date date,
    end_date date,
    serialization character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cover_image_top_offset integer DEFAULT 0,
    volume_count integer,
    chapter_count integer,
    subtype integer DEFAULT 1 NOT NULL,
    average_rating numeric(5,2),
    rating_frequencies public.hstore DEFAULT ''::public.hstore NOT NULL,
    titles public.hstore DEFAULT ''::public.hstore NOT NULL,
    canonical_title character varying DEFAULT 'en_jp'::character varying NOT NULL,
    abbreviated_titles character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    user_count integer DEFAULT 0 NOT NULL,
    popularity_rank integer,
    rating_rank integer,
    age_rating integer,
    age_rating_guide character varying,
    favorites_count integer DEFAULT 0 NOT NULL,
    cover_image_processing boolean,
    tba character varying,
    chapter_count_guess integer,
    release_schedule text,
    original_locale character varying,
    description jsonb DEFAULT '{}'::jsonb NOT NULL,
    poster_image_data jsonb,
    cover_image_data jsonb,
    origin_languages character varying[] DEFAULT '{}'::character varying[],
    origin_countries character varying[] DEFAULT '{}'::character varying[]
);


--
-- Name: manga_characters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manga_characters (
    id integer NOT NULL,
    manga_id integer NOT NULL,
    character_id integer NOT NULL,
    role integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: manga_characters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.manga_characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: manga_characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.manga_characters_id_seq OWNED BY public.manga_characters.id;


--
-- Name: manga_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.manga_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: manga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.manga_id_seq OWNED BY public.manga.id;


--
-- Name: manga_media_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manga_media_attributes (
    id integer NOT NULL,
    manga_id integer NOT NULL,
    media_attribute_id integer NOT NULL,
    high_vote_count integer DEFAULT 0 NOT NULL,
    neutral_vote_count integer DEFAULT 0 NOT NULL,
    low_vote_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: manga_media_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.manga_media_attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: manga_media_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.manga_media_attributes_id_seq OWNED BY public.manga_media_attributes.id;


--
-- Name: manga_staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manga_staff (
    id integer NOT NULL,
    manga_id integer NOT NULL,
    person_id integer NOT NULL,
    role character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: manga_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.manga_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: manga_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.manga_staff_id_seq OWNED BY public.manga_staff.id;


--
-- Name: mappings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mappings (
    id integer NOT NULL,
    external_site character varying NOT NULL,
    external_id character varying NOT NULL,
    item_id integer NOT NULL,
    item_type character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    issue character varying
);


--
-- Name: mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mappings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mappings_id_seq OWNED BY public.mappings.id;


--
-- Name: media_attribute_votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_attribute_votes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    anime_media_attributes_id integer,
    manga_media_attributes_id integer,
    dramas_media_attributes_id integer,
    media_id integer NOT NULL,
    media_type character varying NOT NULL,
    vote integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: media_attribute_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_attribute_votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_attribute_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_attribute_votes_id_seq OWNED BY public.media_attribute_votes.id;


--
-- Name: media_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_attributes (
    id integer NOT NULL,
    title character varying NOT NULL,
    high_title character varying NOT NULL,
    neutral_title character varying NOT NULL,
    low_title character varying NOT NULL,
    slug character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: media_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_attributes_id_seq OWNED BY public.media_attributes.id;


--
-- Name: media_characters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_characters (
    id integer NOT NULL,
    media_id integer NOT NULL,
    media_type character varying NOT NULL,
    character_id integer NOT NULL,
    role integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: media_staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_staff (
    id integer NOT NULL,
    media_id integer NOT NULL,
    media_type character varying NOT NULL,
    person_id integer NOT NULL,
    role character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: media_castings; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.media_castings AS
 SELECT concat('c', mc.id, 'v', cv.id) AS id,
    mc.media_type,
    mc.media_id,
    cv.person_id,
    mc.character_id,
        CASE cv.locale
            WHEN 'fr'::text THEN 'French'::text
            WHEN 'he'::text THEN 'Hebrew'::text
            WHEN 'ja_jp'::text THEN 'Japanese'::text
            WHEN 'hu'::text THEN 'Hungarian'::text
            WHEN 'jp'::text THEN 'Japanese'::text
            WHEN 'pt_br'::text THEN 'Brazilian'::text
            WHEN 'ko'::text THEN 'Korean'::text
            WHEN 'it'::text THEN 'Italian'::text
            WHEN 'en'::text THEN 'English'::text
            WHEN 'us'::text THEN 'English'::text
            WHEN 'es'::text THEN 'Spanish'::text
            WHEN 'de'::text THEN 'German'::text
            ELSE NULL::text
        END AS language,
    (mc.role = 0) AS featured,
    row_number() OVER (PARTITION BY mc.media_type, mc.media_id ORDER BY mc.role, mc.id) AS "order",
    'Voice Actor'::text AS role,
    true AS voice_actor,
    LEAST(mc.created_at, cv.created_at) AS created_at,
    GREATEST(mc.updated_at, cv.updated_at) AS updated_at
   FROM (public.media_characters mc
     JOIN public.character_voices cv ON ((mc.id = cv.media_character_id)))
UNION
 SELECT concat('c', mc.id) AS id,
    mc.media_type,
    mc.media_id,
    NULL::integer AS person_id,
    mc.character_id,
    NULL::text AS language,
    (mc.role = 0) AS featured,
    row_number() OVER (PARTITION BY mc.media_type, mc.media_id ORDER BY mc.role, mc.id) AS "order",
    NULL::text AS role,
    false AS voice_actor,
    mc.created_at,
    mc.updated_at
   FROM (public.media_characters mc
     LEFT JOIN public.character_voices cv ON ((mc.id = cv.media_character_id)))
  WHERE (cv.id IS NULL)
UNION
 SELECT concat('s', ms.id) AS id,
    ms.media_type,
    ms.media_id,
    ms.person_id,
    NULL::integer AS character_id,
    NULL::text AS language,
    false AS featured,
    row_number() OVER (PARTITION BY ms.media_type, ms.media_id ORDER BY ms.id) AS "order",
    ms.role,
    false AS voice_actor,
    ms.created_at,
    ms.updated_at
   FROM public.media_staff ms;


--
-- Name: media_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_categories (
    id bigint NOT NULL,
    media_type character varying NOT NULL,
    media_id bigint NOT NULL,
    category_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: media_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_categories_id_seq OWNED BY public.media_categories.id;


--
-- Name: media_characters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_characters_id_seq OWNED BY public.media_characters.id;


--
-- Name: media_ignores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_ignores (
    id integer NOT NULL,
    media_id integer,
    media_type character varying,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: media_ignores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_ignores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_ignores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_ignores_id_seq OWNED BY public.media_ignores.id;


--
-- Name: media_productions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_productions (
    id integer NOT NULL,
    media_id integer NOT NULL,
    media_type character varying NOT NULL,
    company_id integer NOT NULL,
    role integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: media_productions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_productions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_productions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_productions_id_seq OWNED BY public.media_productions.id;


--
-- Name: media_reaction_votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_reaction_votes (
    id integer NOT NULL,
    user_id integer,
    media_reaction_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: media_reaction_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_reaction_votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_reaction_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_reaction_votes_id_seq OWNED BY public.media_reaction_votes.id;


--
-- Name: media_reactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_reactions (
    id integer NOT NULL,
    user_id integer,
    media_id integer NOT NULL,
    media_type character varying NOT NULL,
    anime_id integer,
    manga_id integer,
    drama_id integer,
    library_entry_id integer,
    up_votes_count integer DEFAULT 0 NOT NULL,
    progress integer DEFAULT 0 NOT NULL,
    reaction character varying(140),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    hidden_at timestamp without time zone
);


--
-- Name: media_reactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_reactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_reactions_id_seq OWNED BY public.media_reactions.id;


--
-- Name: media_relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_relationships (
    id integer NOT NULL,
    source_id integer NOT NULL,
    source_type character varying NOT NULL,
    destination_id integer NOT NULL,
    destination_type character varying NOT NULL,
    role integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: media_relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_relationships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_relationships_id_seq OWNED BY public.media_relationships.id;


--
-- Name: media_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_staff_id_seq OWNED BY public.media_staff.id;


--
-- Name: moderator_action_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.moderator_action_logs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    target_id integer NOT NULL,
    target_type character varying NOT NULL,
    verb character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: moderator_action_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.moderator_action_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: moderator_action_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.moderator_action_logs_id_seq OWNED BY public.moderator_action_logs.id;


--
-- Name: not_interesteds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.not_interesteds (
    id integer NOT NULL,
    user_id integer,
    media_id integer,
    media_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: not_interesteds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.not_interesteds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: not_interesteds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.not_interesteds_id_seq OWNED BY public.not_interesteds.id;


--
-- Name: notification_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_settings (
    id integer NOT NULL,
    setting_type integer NOT NULL,
    user_id integer NOT NULL,
    email_enabled boolean DEFAULT true,
    web_enabled boolean DEFAULT true,
    mobile_enabled boolean DEFAULT true,
    fb_messenger_enabled boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: notification_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notification_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_settings_id_seq OWNED BY public.notification_settings.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer,
    source_id integer,
    source_type character varying(255),
    data public.hstore,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    notification_type character varying(255),
    seen boolean DEFAULT false
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_access_grants (
    id integer NOT NULL,
    resource_owner_id integer NOT NULL,
    application_id integer NOT NULL,
    token character varying NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    scopes character varying
);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_access_grants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_access_grants_id_seq OWNED BY public.oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_access_tokens (
    id integer NOT NULL,
    resource_owner_id integer,
    application_id integer,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying
);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_access_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_access_tokens_id_seq OWNED BY public.oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_applications (
    id integer NOT NULL,
    name character varying NOT NULL,
    uid character varying NOT NULL,
    secret character varying NOT NULL,
    redirect_uri text NOT NULL,
    scopes character varying DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer,
    owner_type character varying,
    confidential boolean DEFAULT true NOT NULL
);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_applications_id_seq OWNED BY public.oauth_applications.id;


--
-- Name: one_signal_players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.one_signal_players (
    id integer NOT NULL,
    user_id integer,
    player_id character varying,
    platform integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: one_signal_players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.one_signal_players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: one_signal_players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.one_signal_players_id_seq OWNED BY public.one_signal_players.id;


--
-- Name: partner_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partner_codes (
    id integer NOT NULL,
    partner_deal_id integer NOT NULL,
    code character varying(255) NOT NULL,
    user_id integer,
    expires_at timestamp without time zone,
    claimed_at timestamp without time zone
);


--
-- Name: partner_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.partner_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: partner_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.partner_codes_id_seq OWNED BY public.partner_codes.id;


--
-- Name: partner_deals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partner_deals (
    id integer NOT NULL,
    deal_title character varying(255) NOT NULL,
    partner_name character varying(255) NOT NULL,
    valid_countries character varying(255)[] DEFAULT '{}'::character varying[] NOT NULL,
    partner_logo_file_name character varying(255),
    partner_logo_content_type character varying(255),
    partner_logo_file_size integer,
    partner_logo_updated_at timestamp without time zone,
    deal_url text NOT NULL,
    deal_description text NOT NULL,
    redemption_info text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    recurring integer DEFAULT 0
);


--
-- Name: partner_deals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.partner_deals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: partner_deals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.partner_deals_id_seq OWNED BY public.partner_deals.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    names jsonb DEFAULT '{}'::jsonb NOT NULL,
    canonical_name character varying NOT NULL,
    other_names character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    birthday date,
    slug public.citext,
    description jsonb DEFAULT '{}'::jsonb NOT NULL,
    image_data jsonb
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- Name: post_follows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_follows (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    post_id integer
);


--
-- Name: post_follows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_follows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_follows_id_seq OWNED BY public.post_follows.id;


--
-- Name: post_likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_likes (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: post_likes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_likes_id_seq OWNED BY public.post_likes.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    target_user_id integer,
    content text,
    content_formatted text,
    media_id integer,
    media_type character varying,
    spoiler boolean DEFAULT false NOT NULL,
    nsfw boolean DEFAULT false NOT NULL,
    blocked boolean DEFAULT false NOT NULL,
    spoiled_unit_id integer,
    spoiled_unit_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    target_group_id integer,
    post_likes_count integer DEFAULT 0 NOT NULL,
    comments_count integer DEFAULT 0 NOT NULL,
    top_level_comments_count integer DEFAULT 0 NOT NULL,
    edited_at timestamp without time zone,
    target_interest character varying,
    embed jsonb,
    community_recommendation_id integer,
    ao_id character varying,
    edited_by_id integer,
    locked_by_id integer,
    locked_at timestamp without time zone,
    locked_reason integer,
    hidden_at timestamp without time zone
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: pro_gifts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pro_gifts (
    id integer NOT NULL,
    from_id integer NOT NULL,
    to_id integer NOT NULL,
    message text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tier integer DEFAULT 0 NOT NULL
);


--
-- Name: pro_gifts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pro_gifts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pro_gifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pro_gifts_id_seq OWNED BY public.pro_gifts.id;


--
-- Name: pro_membership_plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pro_membership_plans (
    id integer NOT NULL,
    name character varying NOT NULL,
    amount integer NOT NULL,
    duration integer NOT NULL,
    recurring boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pro_membership_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pro_membership_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pro_membership_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pro_membership_plans_id_seq OWNED BY public.pro_membership_plans.id;


--
-- Name: pro_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pro_subscriptions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    billing_id character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying NOT NULL,
    tier integer DEFAULT 0 NOT NULL
);


--
-- Name: pro_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pro_subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pro_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pro_subscriptions_id_seq OWNED BY public.pro_subscriptions.id;


--
-- Name: producers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.producers (
    id integer NOT NULL,
    name character varying(255),
    slug public.citext,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: producers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.producers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: producers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.producers_id_seq OWNED BY public.producers.id;


--
-- Name: profile_link_sites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profile_link_sites (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    validate_find character varying,
    validate_replace character varying
);


--
-- Name: profile_link_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profile_link_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profile_link_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profile_link_sites_id_seq OWNED BY public.profile_link_sites.id;


--
-- Name: profile_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profile_links (
    id integer NOT NULL,
    user_id integer NOT NULL,
    profile_link_site_id integer NOT NULL,
    url character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: profile_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profile_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profile_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profile_links_id_seq OWNED BY public.profile_links.id;


--
-- Name: quote_likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quote_likes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    quote_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: quote_likes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quote_likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quote_likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quote_likes_id_seq OWNED BY public.quote_likes.id;


--
-- Name: quote_lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quote_lines (
    id integer NOT NULL,
    quote_id integer NOT NULL,
    character_id integer NOT NULL,
    "order" integer NOT NULL,
    content character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: quote_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quote_lines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quote_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quote_lines_id_seq OWNED BY public.quote_lines.id;


--
-- Name: quotes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quotes (
    id integer NOT NULL,
    media_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    likes_count integer DEFAULT 0 NOT NULL,
    media_type character varying NOT NULL
);


--
-- Name: quotes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quotes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quotes_id_seq OWNED BY public.quotes.id;


--
-- Name: rails_admin_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rails_admin_histories (
    id integer NOT NULL,
    message text,
    username character varying(255),
    item integer,
    "table" character varying(255),
    month integer,
    year integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rails_admin_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rails_admin_histories_id_seq OWNED BY public.rails_admin_histories.id;


--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recommendations (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    recommendations public.hstore
);


--
-- Name: recommendations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recommendations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recommendations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recommendations_id_seq OWNED BY public.recommendations.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    naughty_id integer NOT NULL,
    naughty_type character varying NOT NULL,
    reason integer NOT NULL,
    explanation text,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    moderator_id integer
);


--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: reposts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reposts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: reposts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reposts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reposts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reposts_id_seq OWNED BY public.reposts.id;


--
-- Name: review_likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_likes (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    review_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: review_likes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.review_likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: review_likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.review_likes_id_seq OWNED BY public.review_likes.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    user_id integer NOT NULL,
    media_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rating double precision NOT NULL,
    source character varying(255),
    likes_count integer DEFAULT 0,
    media_type character varying,
    content_formatted text NOT NULL,
    library_entry_id integer,
    progress integer,
    spoiler boolean DEFAULT false NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying,
    resource_id integer,
    resource_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: scrapes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scrapes (
    id integer NOT NULL,
    target_url text NOT NULL,
    scraper_name character varying,
    depth integer DEFAULT 0 NOT NULL,
    max_depth integer DEFAULT 0 NOT NULL,
    parent_id integer,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    original_ancestor_id integer
);


--
-- Name: scrapes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scrapes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scrapes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scrapes_id_seq OWNED BY public.scrapes.id;


--
-- Name: site_announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_announcements (
    id integer NOT NULL,
    user_id integer NOT NULL,
    link character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying NOT NULL,
    image_url character varying,
    description jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: site_announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_announcements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_announcements_id_seq OWNED BY public.site_announcements.id;


--
-- Name: stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stats (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying NOT NULL,
    stats_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    recalculated_at timestamp without time zone NOT NULL
);


--
-- Name: stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stats_id_seq OWNED BY public.stats.id;


--
-- Name: stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stories (
    id integer NOT NULL,
    user_id integer,
    data public.hstore,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    story_type character varying(255),
    target_id integer,
    target_type character varying(255),
    library_entry_id integer,
    adult boolean DEFAULT false,
    total_votes integer DEFAULT 0 NOT NULL,
    group_id integer,
    deleted_at timestamp without time zone
);


--
-- Name: stories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stories_id_seq OWNED BY public.stories.id;


--
-- Name: streamers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.streamers (
    id integer NOT NULL,
    site_name character varying(255) NOT NULL,
    logo_file_name character varying,
    logo_content_type character varying,
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    streaming_links_count integer DEFAULT 0 NOT NULL
);


--
-- Name: streamers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.streamers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: streamers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.streamers_id_seq OWNED BY public.streamers.id;


--
-- Name: streaming_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.streaming_links (
    id integer NOT NULL,
    media_id integer NOT NULL,
    media_type character varying NOT NULL,
    streamer_id integer NOT NULL,
    url character varying NOT NULL,
    subs character varying[] DEFAULT '{en}'::character varying[] NOT NULL,
    dubs character varying[] DEFAULT '{ja}'::character varying[] NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    regions character varying[] DEFAULT '{US}'::character varying[]
);


--
-- Name: streaming_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.streaming_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: streaming_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.streaming_links_id_seq OWNED BY public.streaming_links.id;


--
-- Name: substories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.substories (
    id integer NOT NULL,
    user_id integer,
    story_id integer,
    target_id integer,
    target_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    data public.hstore,
    substory_type integer DEFAULT 0 NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: substories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.substories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: substories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.substories_id_seq OWNED BY public.substories.id;


--
-- Name: uploads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uploads (
    id integer NOT NULL,
    owner_id integer,
    owner_type character varying,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    upload_order integer,
    content_data jsonb
);


--
-- Name: uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.uploads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.uploads_id_seq OWNED BY public.uploads.id;


--
-- Name: user_ip_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_ip_addresses (
    id integer NOT NULL,
    user_id integer NOT NULL,
    ip_address inet NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_ip_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_ip_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_ip_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_ip_addresses_id_seq OWNED BY public.user_ip_addresses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying,
    name character varying(255),
    password_digest character varying(255) DEFAULT ''::character varying,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    recommendations_up_to_date boolean,
    facebook_id character varying(255),
    bio character varying(140) DEFAULT ''::character varying NOT NULL,
    sfw_filter boolean DEFAULT true,
    mal_username character varying(255),
    life_spent_on_anime integer DEFAULT 0 NOT NULL,
    about character varying(500) DEFAULT ''::character varying NOT NULL,
    confirmed_at timestamp without time zone,
    title_language_preference integer DEFAULT 0,
    followers_count integer DEFAULT 0,
    following_count integer DEFAULT 0,
    ninja_banned boolean DEFAULT false,
    last_recommendations_update timestamp without time zone,
    subscribed_to_newsletter boolean DEFAULT true,
    location character varying(255),
    waifu_or_husbando character varying(255),
    waifu_id integer,
    to_follow boolean DEFAULT false,
    dropbox_token character varying(255),
    dropbox_secret character varying(255),
    last_backup timestamp without time zone,
    approved_edit_count integer DEFAULT 0,
    rejected_edit_count integer DEFAULT 0,
    pro_expires_at timestamp without time zone,
    about_formatted text,
    import_status integer,
    import_from character varying(255),
    import_error character varying(255),
    past_names character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    gender character varying,
    birthday date,
    twitter_id character varying,
    comments_count integer DEFAULT 0 NOT NULL,
    likes_given_count integer DEFAULT 0 NOT NULL,
    likes_received_count integer DEFAULT 0 NOT NULL,
    favorites_count integer DEFAULT 0 NOT NULL,
    posts_count integer DEFAULT 0 NOT NULL,
    ratings_count integer DEFAULT 0 NOT NULL,
    reviews_count integer DEFAULT 0 NOT NULL,
    ip_addresses inet[] DEFAULT '{}'::inet[],
    previous_email character varying,
    pinned_post_id integer,
    time_zone character varying,
    language character varying,
    country character varying(2),
    share_to_global boolean DEFAULT true NOT NULL,
    title character varying,
    profile_completed boolean DEFAULT false NOT NULL,
    feed_completed boolean DEFAULT false NOT NULL,
    rating_system integer DEFAULT 0 NOT NULL,
    theme integer DEFAULT 0 NOT NULL,
    deleted_at timestamp without time zone,
    media_reactions_count integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    slug public.citext,
    ao_id character varying,
    ao_password character varying,
    ao_facebook_id character varying,
    ao_pro integer,
    ao_imported character varying,
    pro_started_at timestamp without time zone,
    max_pro_streak integer,
    stripe_customer_id character varying,
    quotes_count integer DEFAULT 0 NOT NULL,
    pro_tier integer,
    pro_message character varying,
    pro_discord_user character varying,
    email_status integer DEFAULT 0,
    permissions integer DEFAULT 0 NOT NULL,
    avatar_data jsonb,
    cover_image_data jsonb,
    sfw_filter_preference integer DEFAULT 0 NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_roles (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_roles_id_seq OWNED BY public.users_roles.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    item_id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    user_id integer,
    object json NOT NULL,
    object_changes json NOT NULL,
    state integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    comment character varying(255)
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.videos (
    id integer NOT NULL,
    url character varying(255) NOT NULL,
    embed_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    regions character varying(255)[] DEFAULT '{US}'::character varying[],
    episode_id integer NOT NULL,
    streamer_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sub_lang character varying(255),
    dub_lang character varying(255),
    subs character varying[] DEFAULT '{en}'::character varying[],
    dubs character varying[] DEFAULT '{ja}'::character varying[]
);


--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- Name: volumes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.volumes (
    id integer NOT NULL,
    titles jsonb DEFAULT '{}'::jsonb NOT NULL,
    canonical_title character varying,
    number integer NOT NULL,
    chapters_count integer DEFAULT 0 NOT NULL,
    manga_id integer NOT NULL,
    isbn character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    published_on date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    thumbnail_data jsonb
);


--
-- Name: volumes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.volumes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: volumes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.volumes_id_seq OWNED BY public.volumes.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.votes (
    id integer NOT NULL,
    target_id integer NOT NULL,
    target_type character varying(255) NOT NULL,
    user_id integer NOT NULL,
    positive boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- Name: wiki_submission_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wiki_submission_logs (
    id bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    user_id bigint,
    wiki_submission_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wiki_submission_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wiki_submission_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_submission_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wiki_submission_logs_id_seq OWNED BY public.wiki_submission_logs.id;


--
-- Name: wiki_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wiki_submissions (
    id bigint NOT NULL,
    title character varying,
    notes text,
    status integer DEFAULT 0 NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    user_id bigint,
    parent_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wiki_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wiki_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wiki_submissions_id_seq OWNED BY public.wiki_submissions.id;


--
-- Name: wordfilters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wordfilters (
    id bigint NOT NULL,
    pattern text NOT NULL,
    regex_enabled boolean DEFAULT false NOT NULL,
    locations integer DEFAULT 0 NOT NULL,
    action integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wordfilters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wordfilters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wordfilters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wordfilters_id_seq OWNED BY public.wordfilters.id;


--
-- Name: ama_subscribers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ama_subscribers ALTER COLUMN id SET DEFAULT nextval('public.ama_subscribers_id_seq'::regclass);


--
-- Name: amas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amas ALTER COLUMN id SET DEFAULT nextval('public.amas_id_seq'::regclass);


--
-- Name: anime id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime ALTER COLUMN id SET DEFAULT nextval('public.anime_id_seq'::regclass);


--
-- Name: anime_castings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_castings ALTER COLUMN id SET DEFAULT nextval('public.anime_castings_id_seq'::regclass);


--
-- Name: anime_characters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_characters ALTER COLUMN id SET DEFAULT nextval('public.anime_characters_id_seq'::regclass);


--
-- Name: anime_media_attributes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_media_attributes ALTER COLUMN id SET DEFAULT nextval('public.anime_media_attributes_id_seq'::regclass);


--
-- Name: anime_productions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_productions ALTER COLUMN id SET DEFAULT nextval('public.anime_productions_id_seq'::regclass);


--
-- Name: anime_staff id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_staff ALTER COLUMN id SET DEFAULT nextval('public.anime_staff_id_seq'::regclass);


--
-- Name: blocks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocks ALTER COLUMN id SET DEFAULT nextval('public.blocks_id_seq'::regclass);


--
-- Name: castings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.castings ALTER COLUMN id SET DEFAULT nextval('public.castings_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: category_favorites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_favorites ALTER COLUMN id SET DEFAULT nextval('public.category_favorites_id_seq'::regclass);


--
-- Name: chapters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapters ALTER COLUMN id SET DEFAULT nextval('public.chapters_id_seq'::regclass);


--
-- Name: character_voices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.character_voices ALTER COLUMN id SET DEFAULT nextval('public.character_voices_id_seq'::regclass);


--
-- Name: characters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characters ALTER COLUMN id SET DEFAULT nextval('public.characters_id_seq'::regclass);


--
-- Name: comment_likes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment_likes ALTER COLUMN id SET DEFAULT nextval('public.comment_likes_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: community_recommendation_follows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_recommendation_follows ALTER COLUMN id SET DEFAULT nextval('public.community_recommendation_follows_id_seq'::regclass);


--
-- Name: community_recommendation_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_recommendation_requests ALTER COLUMN id SET DEFAULT nextval('public.community_recommendation_requests_id_seq'::regclass);


--
-- Name: community_recommendations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_recommendations ALTER COLUMN id SET DEFAULT nextval('public.community_recommendations_id_seq'::regclass);


--
-- Name: drama_castings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_castings ALTER COLUMN id SET DEFAULT nextval('public.drama_castings_id_seq'::regclass);


--
-- Name: drama_characters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_characters ALTER COLUMN id SET DEFAULT nextval('public.drama_characters_id_seq'::regclass);


--
-- Name: drama_staff id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_staff ALTER COLUMN id SET DEFAULT nextval('public.drama_staff_id_seq'::regclass);


--
-- Name: dramas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dramas ALTER COLUMN id SET DEFAULT nextval('public.dramas_id_seq'::regclass);


--
-- Name: dramas_media_attributes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dramas_media_attributes ALTER COLUMN id SET DEFAULT nextval('public.dramas_media_attributes_id_seq'::regclass);


--
-- Name: episodes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.episodes ALTER COLUMN id SET DEFAULT nextval('public.episodes_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: follows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows ALTER COLUMN id SET DEFAULT nextval('public.follows_id_seq'::regclass);


--
-- Name: franchises id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.franchises ALTER COLUMN id SET DEFAULT nextval('public.franchises_id_seq'::regclass);


--
-- Name: friendly_id_slugs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('public.friendly_id_slugs_id_seq'::regclass);


--
-- Name: gallery_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gallery_images ALTER COLUMN id SET DEFAULT nextval('public.gallery_images_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Name: global_stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.global_stats ALTER COLUMN id SET DEFAULT nextval('public.global_stats_id_seq'::regclass);


--
-- Name: group_action_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_action_logs ALTER COLUMN id SET DEFAULT nextval('public.group_action_logs_id_seq'::regclass);


--
-- Name: group_bans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_bans ALTER COLUMN id SET DEFAULT nextval('public.group_bans_id_seq'::regclass);


--
-- Name: group_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_categories ALTER COLUMN id SET DEFAULT nextval('public.group_categories_id_seq'::regclass);


--
-- Name: group_invites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_invites ALTER COLUMN id SET DEFAULT nextval('public.group_invites_id_seq'::regclass);


--
-- Name: group_member_notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_member_notes ALTER COLUMN id SET DEFAULT nextval('public.group_member_notes_id_seq'::regclass);


--
-- Name: group_members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_members ALTER COLUMN id SET DEFAULT nextval('public.group_members_id_seq'::regclass);


--
-- Name: group_neighbors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_neighbors ALTER COLUMN id SET DEFAULT nextval('public.group_neighbors_id_seq'::regclass);


--
-- Name: group_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_permissions ALTER COLUMN id SET DEFAULT nextval('public.group_permissions_id_seq'::regclass);


--
-- Name: group_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_reports ALTER COLUMN id SET DEFAULT nextval('public.group_reports_id_seq'::regclass);


--
-- Name: group_ticket_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_ticket_messages ALTER COLUMN id SET DEFAULT nextval('public.group_ticket_messages_id_seq'::regclass);


--
-- Name: group_tickets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_tickets ALTER COLUMN id SET DEFAULT nextval('public.group_tickets_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: hashtags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hashtags ALTER COLUMN id SET DEFAULT nextval('public.hashtags_id_seq'::regclass);


--
-- Name: installments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.installments ALTER COLUMN id SET DEFAULT nextval('public.installments_id_seq'::regclass);


--
-- Name: leader_chat_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leader_chat_messages ALTER COLUMN id SET DEFAULT nextval('public.leader_chat_messages_id_seq'::regclass);


--
-- Name: library_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_entries ALTER COLUMN id SET DEFAULT nextval('public.library_entries_id_seq'::regclass);


--
-- Name: library_entry_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_entry_logs ALTER COLUMN id SET DEFAULT nextval('public.library_entry_logs_id_seq'::regclass);


--
-- Name: library_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_events ALTER COLUMN id SET DEFAULT nextval('public.library_events_id_seq'::regclass);


--
-- Name: linked_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linked_accounts ALTER COLUMN id SET DEFAULT nextval('public.linked_accounts_id_seq'::regclass);


--
-- Name: list_imports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.list_imports ALTER COLUMN id SET DEFAULT nextval('public.list_imports_id_seq'::regclass);


--
-- Name: manga id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga ALTER COLUMN id SET DEFAULT nextval('public.manga_id_seq'::regclass);


--
-- Name: manga_characters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_characters ALTER COLUMN id SET DEFAULT nextval('public.manga_characters_id_seq'::regclass);


--
-- Name: manga_media_attributes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_media_attributes ALTER COLUMN id SET DEFAULT nextval('public.manga_media_attributes_id_seq'::regclass);


--
-- Name: manga_staff id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_staff ALTER COLUMN id SET DEFAULT nextval('public.manga_staff_id_seq'::regclass);


--
-- Name: mappings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mappings ALTER COLUMN id SET DEFAULT nextval('public.mappings_id_seq'::regclass);


--
-- Name: media_attribute_votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_attribute_votes ALTER COLUMN id SET DEFAULT nextval('public.media_attribute_votes_id_seq'::regclass);


--
-- Name: media_attributes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_attributes ALTER COLUMN id SET DEFAULT nextval('public.media_attributes_id_seq'::regclass);


--
-- Name: media_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_categories ALTER COLUMN id SET DEFAULT nextval('public.media_categories_id_seq'::regclass);


--
-- Name: media_characters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_characters ALTER COLUMN id SET DEFAULT nextval('public.media_characters_id_seq'::regclass);


--
-- Name: media_ignores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_ignores ALTER COLUMN id SET DEFAULT nextval('public.media_ignores_id_seq'::regclass);


--
-- Name: media_productions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_productions ALTER COLUMN id SET DEFAULT nextval('public.media_productions_id_seq'::regclass);


--
-- Name: media_reaction_votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_reaction_votes ALTER COLUMN id SET DEFAULT nextval('public.media_reaction_votes_id_seq'::regclass);


--
-- Name: media_reactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_reactions ALTER COLUMN id SET DEFAULT nextval('public.media_reactions_id_seq'::regclass);


--
-- Name: media_relationships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_relationships ALTER COLUMN id SET DEFAULT nextval('public.media_relationships_id_seq'::regclass);


--
-- Name: media_staff id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_staff ALTER COLUMN id SET DEFAULT nextval('public.media_staff_id_seq'::regclass);


--
-- Name: moderator_action_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderator_action_logs ALTER COLUMN id SET DEFAULT nextval('public.moderator_action_logs_id_seq'::regclass);


--
-- Name: not_interesteds id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.not_interesteds ALTER COLUMN id SET DEFAULT nextval('public.not_interesteds_id_seq'::regclass);


--
-- Name: notification_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_settings ALTER COLUMN id SET DEFAULT nextval('public.notification_settings_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: oauth_access_grants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_grants_id_seq'::regclass);


--
-- Name: oauth_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth_access_tokens_id_seq'::regclass);


--
-- Name: oauth_applications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_applications ALTER COLUMN id SET DEFAULT nextval('public.oauth_applications_id_seq'::regclass);


--
-- Name: one_signal_players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.one_signal_players ALTER COLUMN id SET DEFAULT nextval('public.one_signal_players_id_seq'::regclass);


--
-- Name: partner_codes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partner_codes ALTER COLUMN id SET DEFAULT nextval('public.partner_codes_id_seq'::regclass);


--
-- Name: partner_deals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partner_deals ALTER COLUMN id SET DEFAULT nextval('public.partner_deals_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- Name: post_follows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_follows ALTER COLUMN id SET DEFAULT nextval('public.post_follows_id_seq'::regclass);


--
-- Name: post_likes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_likes ALTER COLUMN id SET DEFAULT nextval('public.post_likes_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: pro_gifts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pro_gifts ALTER COLUMN id SET DEFAULT nextval('public.pro_gifts_id_seq'::regclass);


--
-- Name: pro_membership_plans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pro_membership_plans ALTER COLUMN id SET DEFAULT nextval('public.pro_membership_plans_id_seq'::regclass);


--
-- Name: pro_subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pro_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.pro_subscriptions_id_seq'::regclass);


--
-- Name: producers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producers ALTER COLUMN id SET DEFAULT nextval('public.producers_id_seq'::regclass);


--
-- Name: profile_link_sites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_link_sites ALTER COLUMN id SET DEFAULT nextval('public.profile_link_sites_id_seq'::regclass);


--
-- Name: profile_links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_links ALTER COLUMN id SET DEFAULT nextval('public.profile_links_id_seq'::regclass);


--
-- Name: quote_likes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quote_likes ALTER COLUMN id SET DEFAULT nextval('public.quote_likes_id_seq'::regclass);


--
-- Name: quote_lines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quote_lines ALTER COLUMN id SET DEFAULT nextval('public.quote_lines_id_seq'::regclass);


--
-- Name: quotes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotes ALTER COLUMN id SET DEFAULT nextval('public.quotes_id_seq'::regclass);


--
-- Name: rails_admin_histories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rails_admin_histories ALTER COLUMN id SET DEFAULT nextval('public.rails_admin_histories_id_seq'::regclass);


--
-- Name: recommendations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations ALTER COLUMN id SET DEFAULT nextval('public.recommendations_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: reposts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reposts ALTER COLUMN id SET DEFAULT nextval('public.reposts_id_seq'::regclass);


--
-- Name: review_likes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review_likes ALTER COLUMN id SET DEFAULT nextval('public.review_likes_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: scrapes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scrapes ALTER COLUMN id SET DEFAULT nextval('public.scrapes_id_seq'::regclass);


--
-- Name: site_announcements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_announcements ALTER COLUMN id SET DEFAULT nextval('public.site_announcements_id_seq'::regclass);


--
-- Name: stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stats ALTER COLUMN id SET DEFAULT nextval('public.stats_id_seq'::regclass);


--
-- Name: stories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories ALTER COLUMN id SET DEFAULT nextval('public.stories_id_seq'::regclass);


--
-- Name: streamers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streamers ALTER COLUMN id SET DEFAULT nextval('public.streamers_id_seq'::regclass);


--
-- Name: streaming_links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streaming_links ALTER COLUMN id SET DEFAULT nextval('public.streaming_links_id_seq'::regclass);


--
-- Name: substories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.substories ALTER COLUMN id SET DEFAULT nextval('public.substories_id_seq'::regclass);


--
-- Name: uploads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploads ALTER COLUMN id SET DEFAULT nextval('public.uploads_id_seq'::regclass);


--
-- Name: user_ip_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_ip_addresses ALTER COLUMN id SET DEFAULT nextval('public.user_ip_addresses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_roles ALTER COLUMN id SET DEFAULT nextval('public.users_roles_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- Name: volumes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volumes ALTER COLUMN id SET DEFAULT nextval('public.volumes_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Name: wiki_submission_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_submission_logs ALTER COLUMN id SET DEFAULT nextval('public.wiki_submission_logs_id_seq'::regclass);


--
-- Name: wiki_submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_submissions ALTER COLUMN id SET DEFAULT nextval('public.wiki_submissions_id_seq'::regclass);


--
-- Name: wordfilters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wordfilters ALTER COLUMN id SET DEFAULT nextval('public.wordfilters_id_seq'::regclass);


--
-- Name: ama_subscribers ama_subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ama_subscribers
    ADD CONSTRAINT ama_subscribers_pkey PRIMARY KEY (id);


--
-- Name: amas amas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amas
    ADD CONSTRAINT amas_pkey PRIMARY KEY (id);


--
-- Name: anime_castings anime_castings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_castings
    ADD CONSTRAINT anime_castings_pkey PRIMARY KEY (id);


--
-- Name: anime_characters anime_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_characters
    ADD CONSTRAINT anime_characters_pkey PRIMARY KEY (id);


--
-- Name: anime_media_attributes anime_media_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_media_attributes
    ADD CONSTRAINT anime_media_attributes_pkey PRIMARY KEY (id);


--
-- Name: anime anime_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime
    ADD CONSTRAINT anime_pkey PRIMARY KEY (id);


--
-- Name: anime_productions anime_productions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_productions
    ADD CONSTRAINT anime_productions_pkey PRIMARY KEY (id);


--
-- Name: anime_staff anime_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_staff
    ADD CONSTRAINT anime_staff_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (id);


--
-- Name: castings castings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.castings
    ADD CONSTRAINT castings_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: category_favorites category_favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_favorites
    ADD CONSTRAINT category_favorites_pkey PRIMARY KEY (id);


--
-- Name: chapters chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);


--
-- Name: character_voices character_voices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.character_voices
    ADD CONSTRAINT character_voices_pkey PRIMARY KEY (id);


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id);


--
-- Name: comment_likes comment_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT comment_likes_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: community_recommendation_follows community_recommendation_follows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_recommendation_follows
    ADD CONSTRAINT community_recommendation_follows_pkey PRIMARY KEY (id);


--
-- Name: community_recommendation_requests community_recommendation_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_recommendation_requests
    ADD CONSTRAINT community_recommendation_requests_pkey PRIMARY KEY (id);


--
-- Name: community_recommendations community_recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_recommendations
    ADD CONSTRAINT community_recommendations_pkey PRIMARY KEY (id);


--
-- Name: drama_castings drama_castings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_castings
    ADD CONSTRAINT drama_castings_pkey PRIMARY KEY (id);


--
-- Name: drama_characters drama_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_characters
    ADD CONSTRAINT drama_characters_pkey PRIMARY KEY (id);


--
-- Name: drama_staff drama_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_staff
    ADD CONSTRAINT drama_staff_pkey PRIMARY KEY (id);


--
-- Name: dramas_media_attributes dramas_media_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dramas_media_attributes
    ADD CONSTRAINT dramas_media_attributes_pkey PRIMARY KEY (id);


--
-- Name: dramas dramas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dramas
    ADD CONSTRAINT dramas_pkey PRIMARY KEY (id);


--
-- Name: episodes episodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: franchises franchises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.franchises
    ADD CONSTRAINT franchises_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: gallery_images gallery_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gallery_images
    ADD CONSTRAINT gallery_images_pkey PRIMARY KEY (id);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: global_stats global_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.global_stats
    ADD CONSTRAINT global_stats_pkey PRIMARY KEY (id);


--
-- Name: group_action_logs group_action_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_action_logs
    ADD CONSTRAINT group_action_logs_pkey PRIMARY KEY (id);


--
-- Name: group_bans group_bans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_bans
    ADD CONSTRAINT group_bans_pkey PRIMARY KEY (id);


--
-- Name: group_categories group_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_categories
    ADD CONSTRAINT group_categories_pkey PRIMARY KEY (id);


--
-- Name: group_invites group_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_invites
    ADD CONSTRAINT group_invites_pkey PRIMARY KEY (id);


--
-- Name: group_member_notes group_member_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_member_notes
    ADD CONSTRAINT group_member_notes_pkey PRIMARY KEY (id);


--
-- Name: group_members group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_pkey PRIMARY KEY (id);


--
-- Name: group_neighbors group_neighbors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_neighbors
    ADD CONSTRAINT group_neighbors_pkey PRIMARY KEY (id);


--
-- Name: group_permissions group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_permissions
    ADD CONSTRAINT group_permissions_pkey PRIMARY KEY (id);


--
-- Name: group_reports group_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_reports
    ADD CONSTRAINT group_reports_pkey PRIMARY KEY (id);


--
-- Name: group_ticket_messages group_ticket_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_ticket_messages
    ADD CONSTRAINT group_ticket_messages_pkey PRIMARY KEY (id);


--
-- Name: group_tickets group_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_tickets
    ADD CONSTRAINT group_tickets_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: hashtags hashtags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hashtags
    ADD CONSTRAINT hashtags_pkey PRIMARY KEY (id);


--
-- Name: installments installments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.installments
    ADD CONSTRAINT installments_pkey PRIMARY KEY (id);


--
-- Name: leader_chat_messages leader_chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leader_chat_messages
    ADD CONSTRAINT leader_chat_messages_pkey PRIMARY KEY (id);


--
-- Name: library_entries library_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_entries
    ADD CONSTRAINT library_entries_pkey PRIMARY KEY (id);


--
-- Name: library_entry_logs library_entry_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_entry_logs
    ADD CONSTRAINT library_entry_logs_pkey PRIMARY KEY (id);


--
-- Name: library_events library_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_events
    ADD CONSTRAINT library_events_pkey PRIMARY KEY (id);


--
-- Name: linked_accounts linked_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linked_accounts
    ADD CONSTRAINT linked_accounts_pkey PRIMARY KEY (id);


--
-- Name: list_imports list_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.list_imports
    ADD CONSTRAINT list_imports_pkey PRIMARY KEY (id);


--
-- Name: manga_characters manga_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_characters
    ADD CONSTRAINT manga_characters_pkey PRIMARY KEY (id);


--
-- Name: manga_media_attributes manga_media_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_media_attributes
    ADD CONSTRAINT manga_media_attributes_pkey PRIMARY KEY (id);


--
-- Name: manga manga_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga
    ADD CONSTRAINT manga_pkey PRIMARY KEY (id);


--
-- Name: manga_staff manga_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_staff
    ADD CONSTRAINT manga_staff_pkey PRIMARY KEY (id);


--
-- Name: mappings mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mappings
    ADD CONSTRAINT mappings_pkey PRIMARY KEY (id);


--
-- Name: media_attribute_votes media_attribute_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_attribute_votes
    ADD CONSTRAINT media_attribute_votes_pkey PRIMARY KEY (id);


--
-- Name: media_attributes media_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_attributes
    ADD CONSTRAINT media_attributes_pkey PRIMARY KEY (id);


--
-- Name: media_categories media_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_categories
    ADD CONSTRAINT media_categories_pkey PRIMARY KEY (id);


--
-- Name: media_characters media_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_characters
    ADD CONSTRAINT media_characters_pkey PRIMARY KEY (id);


--
-- Name: media_ignores media_ignores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_ignores
    ADD CONSTRAINT media_ignores_pkey PRIMARY KEY (id);


--
-- Name: media_productions media_productions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_productions
    ADD CONSTRAINT media_productions_pkey PRIMARY KEY (id);


--
-- Name: media_reaction_votes media_reaction_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_reaction_votes
    ADD CONSTRAINT media_reaction_votes_pkey PRIMARY KEY (id);


--
-- Name: media_reactions media_reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_reactions
    ADD CONSTRAINT media_reactions_pkey PRIMARY KEY (id);


--
-- Name: media_relationships media_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_relationships
    ADD CONSTRAINT media_relationships_pkey PRIMARY KEY (id);


--
-- Name: media_staff media_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_staff
    ADD CONSTRAINT media_staff_pkey PRIMARY KEY (id);


--
-- Name: moderator_action_logs moderator_action_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderator_action_logs
    ADD CONSTRAINT moderator_action_logs_pkey PRIMARY KEY (id);


--
-- Name: not_interesteds not_interesteds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.not_interesteds
    ADD CONSTRAINT not_interesteds_pkey PRIMARY KEY (id);


--
-- Name: notification_settings notification_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_settings
    ADD CONSTRAINT notification_settings_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: one_signal_players one_signal_players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.one_signal_players
    ADD CONSTRAINT one_signal_players_pkey PRIMARY KEY (id);


--
-- Name: partner_codes partner_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partner_codes
    ADD CONSTRAINT partner_codes_pkey PRIMARY KEY (id);


--
-- Name: partner_deals partner_deals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partner_deals
    ADD CONSTRAINT partner_deals_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: post_follows post_follows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_follows
    ADD CONSTRAINT post_follows_pkey PRIMARY KEY (id);


--
-- Name: post_likes post_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_likes
    ADD CONSTRAINT post_likes_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: pro_gifts pro_gifts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pro_gifts
    ADD CONSTRAINT pro_gifts_pkey PRIMARY KEY (id);


--
-- Name: pro_membership_plans pro_membership_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pro_membership_plans
    ADD CONSTRAINT pro_membership_plans_pkey PRIMARY KEY (id);


--
-- Name: pro_subscriptions pro_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pro_subscriptions
    ADD CONSTRAINT pro_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: producers producers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producers
    ADD CONSTRAINT producers_pkey PRIMARY KEY (id);


--
-- Name: profile_link_sites profile_link_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_link_sites
    ADD CONSTRAINT profile_link_sites_pkey PRIMARY KEY (id);


--
-- Name: profile_links profile_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_links
    ADD CONSTRAINT profile_links_pkey PRIMARY KEY (id);


--
-- Name: quote_likes quote_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quote_likes
    ADD CONSTRAINT quote_likes_pkey PRIMARY KEY (id);


--
-- Name: quote_lines quote_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quote_lines
    ADD CONSTRAINT quote_lines_pkey PRIMARY KEY (id);


--
-- Name: quotes quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotes
    ADD CONSTRAINT quotes_pkey PRIMARY KEY (id);


--
-- Name: rails_admin_histories rails_admin_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rails_admin_histories
    ADD CONSTRAINT rails_admin_histories_pkey PRIMARY KEY (id);


--
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: reposts reposts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reposts
    ADD CONSTRAINT reposts_pkey PRIMARY KEY (id);


--
-- Name: review_likes review_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review_likes
    ADD CONSTRAINT review_likes_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: scrapes scrapes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scrapes
    ADD CONSTRAINT scrapes_pkey PRIMARY KEY (id);


--
-- Name: site_announcements site_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_announcements
    ADD CONSTRAINT site_announcements_pkey PRIMARY KEY (id);


--
-- Name: stats stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (id);


--
-- Name: stories stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_pkey PRIMARY KEY (id);


--
-- Name: streamers streamers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streamers
    ADD CONSTRAINT streamers_pkey PRIMARY KEY (id);


--
-- Name: streaming_links streaming_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streaming_links
    ADD CONSTRAINT streaming_links_pkey PRIMARY KEY (id);


--
-- Name: substories substories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.substories
    ADD CONSTRAINT substories_pkey PRIMARY KEY (id);


--
-- Name: uploads uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploads
    ADD CONSTRAINT uploads_pkey PRIMARY KEY (id);


--
-- Name: user_ip_addresses user_ip_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_ip_addresses
    ADD CONSTRAINT user_ip_addresses_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: volumes volumes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volumes
    ADD CONSTRAINT volumes_pkey PRIMARY KEY (id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: wiki_submission_logs wiki_submission_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_submission_logs
    ADD CONSTRAINT wiki_submission_logs_pkey PRIMARY KEY (id);


--
-- Name: wiki_submissions wiki_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_submissions
    ADD CONSTRAINT wiki_submissions_pkey PRIMARY KEY (id);


--
-- Name: wordfilters wordfilters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wordfilters
    ADD CONSTRAINT wordfilters_pkey PRIMARY KEY (id);


--
-- Name: anime_average_rating_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX anime_average_rating_idx ON public.anime USING btree (average_rating);


--
-- Name: character_mal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX character_mal_id ON public.characters USING btree (mal_id);


--
-- Name: index_ama_subscribers_on_ama_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ama_subscribers_on_ama_id ON public.ama_subscribers USING btree (ama_id);


--
-- Name: index_ama_subscribers_on_ama_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_ama_subscribers_on_ama_id_and_user_id ON public.ama_subscribers USING btree (ama_id, user_id);


--
-- Name: index_ama_subscribers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ama_subscribers_on_user_id ON public.ama_subscribers USING btree (user_id);


--
-- Name: index_amas_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_amas_on_author_id ON public.amas USING btree (author_id);


--
-- Name: index_amas_on_original_post_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_amas_on_original_post_id ON public.amas USING btree (original_post_id);


--
-- Name: index_anime_castings_on_anime_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_castings_on_anime_character_id ON public.anime_castings USING btree (anime_character_id);


--
-- Name: index_anime_castings_on_character_person_locale; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_anime_castings_on_character_person_locale ON public.anime_castings USING btree (anime_character_id, person_id, locale);


--
-- Name: index_anime_castings_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_castings_on_person_id ON public.anime_castings USING btree (person_id);


--
-- Name: index_anime_characters_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_characters_on_anime_id ON public.anime_characters USING btree (anime_id);


--
-- Name: index_anime_characters_on_anime_id_and_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_anime_characters_on_anime_id_and_character_id ON public.anime_characters USING btree (anime_id, character_id);


--
-- Name: index_anime_characters_on_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_characters_on_character_id ON public.anime_characters USING btree (character_id);


--
-- Name: index_anime_genres_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_genres_on_anime_id ON public.anime_genres USING btree (anime_id);


--
-- Name: index_anime_genres_on_genre_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_genres_on_genre_id ON public.anime_genres USING btree (genre_id);


--
-- Name: index_anime_media_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_anime_media_attribute ON public.anime_media_attributes USING btree (anime_id, media_attribute_id);


--
-- Name: index_anime_media_attributes_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_media_attributes_on_anime_id ON public.anime_media_attributes USING btree (anime_id);


--
-- Name: index_anime_media_attributes_on_media_attribute_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_media_attributes_on_media_attribute_id ON public.anime_media_attributes USING btree (media_attribute_id);


--
-- Name: index_anime_on_age_rating; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_on_age_rating ON public.anime USING btree (age_rating);


--
-- Name: index_anime_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_anime_on_slug ON public.anime USING btree (slug);


--
-- Name: index_anime_on_user_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_on_user_count ON public.anime USING btree (user_count);


--
-- Name: index_anime_on_wilson_ci; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_on_wilson_ci ON public.anime USING btree (average_rating DESC);


--
-- Name: index_anime_productions_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_productions_on_anime_id ON public.anime_productions USING btree (anime_id);


--
-- Name: index_anime_productions_on_producer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_productions_on_producer_id ON public.anime_productions USING btree (producer_id);


--
-- Name: index_anime_staff_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_staff_on_anime_id ON public.anime_staff USING btree (anime_id);


--
-- Name: index_anime_staff_on_anime_id_and_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_anime_staff_on_anime_id_and_person_id ON public.anime_staff USING btree (anime_id, person_id);


--
-- Name: index_anime_staff_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anime_staff_on_person_id ON public.anime_staff USING btree (person_id);


--
-- Name: index_blocks_on_blocked_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blocks_on_blocked_id ON public.blocks USING btree (blocked_id);


--
-- Name: index_blocks_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blocks_on_user_id ON public.blocks USING btree (user_id);


--
-- Name: index_castings_on_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_castings_on_character_id ON public.castings USING btree (character_id);


--
-- Name: index_castings_on_media_id_and_media_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_castings_on_media_id_and_media_type ON public.castings USING btree (media_id, media_type);


--
-- Name: index_castings_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_castings_on_person_id ON public.castings USING btree (person_id);


--
-- Name: index_categories_on_ancestry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_ancestry ON public.categories USING btree (ancestry text_pattern_ops);


--
-- Name: index_categories_on_anidb_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_anidb_id ON public.categories USING btree (anidb_id);


--
-- Name: index_categories_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_parent_id ON public.categories USING btree (parent_id);


--
-- Name: index_categories_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_slug ON public.categories USING btree (slug);


--
-- Name: index_category_favorites_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_category_favorites_on_category_id ON public.category_favorites USING btree (category_id);


--
-- Name: index_category_favorites_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_category_favorites_on_user_id ON public.category_favorites USING btree (user_id);


--
-- Name: index_chapters_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chapters_on_manga_id ON public.chapters USING btree (manga_id);


--
-- Name: index_character_voices_on_media_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_character_voices_on_media_character_id ON public.character_voices USING btree (media_character_id);


--
-- Name: index_character_voices_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_character_voices_on_person_id ON public.character_voices USING btree (person_id);


--
-- Name: index_characters_on_mal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_characters_on_mal_id ON public.characters USING btree (mal_id);


--
-- Name: index_characters_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_characters_on_slug ON public.characters USING btree (slug);


--
-- Name: index_comment_likes_on_comment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comment_likes_on_comment_id ON public.comment_likes USING btree (comment_id);


--
-- Name: index_comment_likes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comment_likes_on_user_id ON public.comment_likes USING btree (user_id);


--
-- Name: index_comment_likes_on_user_id_and_comment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_comment_likes_on_user_id_and_comment_id ON public.comment_likes USING btree (user_id, comment_id);


--
-- Name: index_comments_on_ao_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_comments_on_ao_id ON public.comments USING btree (ao_id);


--
-- Name: index_comments_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_deleted_at ON public.comments USING btree (deleted_at);


--
-- Name: index_comments_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_parent_id ON public.comments USING btree (parent_id);


--
-- Name: index_comments_on_post_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_post_id ON public.comments USING btree (post_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_community_recommendation_follows_on_user_and_request; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_community_recommendation_follows_on_user_and_request ON public.community_recommendation_follows USING btree (user_id, community_recommendation_request_id);


--
-- Name: index_community_recommendation_follows_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_recommendation_follows_on_user_id ON public.community_recommendation_follows USING btree (user_id);


--
-- Name: index_community_recommendation_requests_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_recommendation_requests_on_user_id ON public.community_recommendation_requests USING btree (user_id);


--
-- Name: index_community_recommendations_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_recommendations_on_anime_id ON public.community_recommendations USING btree (anime_id);


--
-- Name: index_community_recommendations_on_drama_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_recommendations_on_drama_id ON public.community_recommendations USING btree (drama_id);


--
-- Name: index_community_recommendations_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_recommendations_on_manga_id ON public.community_recommendations USING btree (manga_id);


--
-- Name: index_community_recommendations_on_media_id_and_media_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_community_recommendations_on_media_id_and_media_type ON public.community_recommendations USING btree (media_id, media_type);


--
-- Name: index_community_recommendations_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_community_recommendations_on_media_type_and_media_id ON public.community_recommendations USING btree (media_type, media_id);


--
-- Name: index_drama_castings_on_character_person_locale; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_drama_castings_on_character_person_locale ON public.drama_castings USING btree (drama_character_id, person_id, locale);


--
-- Name: index_drama_castings_on_drama_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drama_castings_on_drama_character_id ON public.drama_castings USING btree (drama_character_id);


--
-- Name: index_drama_castings_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drama_castings_on_person_id ON public.drama_castings USING btree (person_id);


--
-- Name: index_drama_characters_on_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drama_characters_on_character_id ON public.drama_characters USING btree (character_id);


--
-- Name: index_drama_characters_on_drama_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drama_characters_on_drama_id ON public.drama_characters USING btree (drama_id);


--
-- Name: index_drama_characters_on_drama_id_and_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_drama_characters_on_drama_id_and_character_id ON public.drama_characters USING btree (drama_id, character_id);


--
-- Name: index_drama_media_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_drama_media_attribute ON public.dramas_media_attributes USING btree (drama_id, media_attribute_id);


--
-- Name: index_drama_staff_on_drama_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drama_staff_on_drama_id ON public.drama_staff USING btree (drama_id);


--
-- Name: index_drama_staff_on_drama_id_and_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_drama_staff_on_drama_id_and_person_id ON public.drama_staff USING btree (drama_id, person_id);


--
-- Name: index_drama_staff_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drama_staff_on_person_id ON public.drama_staff USING btree (person_id);


--
-- Name: index_dramas_media_attributes_on_drama_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dramas_media_attributes_on_drama_id ON public.dramas_media_attributes USING btree (drama_id);


--
-- Name: index_dramas_media_attributes_on_media_attribute_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dramas_media_attributes_on_media_attribute_id ON public.dramas_media_attributes USING btree (media_attribute_id);


--
-- Name: index_dramas_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dramas_on_slug ON public.dramas USING btree (slug);


--
-- Name: index_episodes_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_episodes_on_media_type_and_media_id ON public.episodes USING btree (media_type, media_id);


--
-- Name: index_favorite_genres_users_on_genre_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_favorite_genres_users_on_genre_id_and_user_id ON public.favorite_genres_users USING btree (genre_id, user_id);


--
-- Name: index_favorites_on_item_id_and_item_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_favorites_on_item_id_and_item_type ON public.favorites USING btree (item_id, item_type);


--
-- Name: index_favorites_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_favorites_on_user_id ON public.favorites USING btree (user_id);


--
-- Name: index_favorites_on_user_id_and_item_id_and_item_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_favorites_on_user_id_and_item_id_and_item_type ON public.favorites USING btree (user_id, item_id, item_type);


--
-- Name: index_favorites_on_user_id_and_item_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_favorites_on_user_id_and_item_type ON public.favorites USING btree (user_id, item_type);


--
-- Name: index_follows_on_followed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_follows_on_followed_id ON public.follows USING btree (follower_id);


--
-- Name: index_follows_on_followed_id_and_follower_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_follows_on_followed_id_and_follower_id ON public.follows USING btree (followed_id, follower_id);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON public.friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON public.friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON public.friendly_id_slugs USING btree (sluggable_type);


--
-- Name: index_gallery_images_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gallery_images_on_anime_id ON public.gallery_images USING btree (anime_id);


--
-- Name: index_genres_manga_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_genres_manga_on_manga_id ON public.genres_manga USING btree (manga_id);


--
-- Name: index_group_action_logs_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_action_logs_on_created_at ON public.group_action_logs USING btree (created_at);


--
-- Name: index_group_action_logs_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_action_logs_on_group_id ON public.group_action_logs USING btree (group_id);


--
-- Name: index_group_bans_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_bans_on_group_id ON public.group_bans USING btree (group_id);


--
-- Name: index_group_bans_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_bans_on_user_id ON public.group_bans USING btree (user_id);


--
-- Name: index_group_invites_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_invites_on_group_id ON public.group_invites USING btree (group_id);


--
-- Name: index_group_invites_on_sender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_invites_on_sender_id ON public.group_invites USING btree (sender_id);


--
-- Name: index_group_invites_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_invites_on_user_id ON public.group_invites USING btree (user_id);


--
-- Name: index_group_members_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_members_on_group_id ON public.group_members USING btree (group_id);


--
-- Name: index_group_members_on_rank; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_members_on_rank ON public.group_members USING btree (rank);


--
-- Name: index_group_members_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_members_on_user_id ON public.group_members USING btree (user_id);


--
-- Name: index_group_members_on_user_id_and_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_group_members_on_user_id_and_group_id ON public.group_members USING btree (user_id, group_id);


--
-- Name: index_group_neighbors_on_destination_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_neighbors_on_destination_id ON public.group_neighbors USING btree (destination_id);


--
-- Name: index_group_neighbors_on_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_neighbors_on_source_id ON public.group_neighbors USING btree (source_id);


--
-- Name: index_group_permissions_on_group_member_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_permissions_on_group_member_id ON public.group_permissions USING btree (group_member_id);


--
-- Name: index_group_reports_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_reports_on_group_id ON public.group_reports USING btree (group_id);


--
-- Name: index_group_reports_on_naughty_type_and_naughty_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_reports_on_naughty_type_and_naughty_id ON public.group_reports USING btree (naughty_type, naughty_id);


--
-- Name: index_group_reports_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_reports_on_status ON public.group_reports USING btree (status);


--
-- Name: index_group_reports_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_reports_on_user_id ON public.group_reports USING btree (user_id);


--
-- Name: index_group_ticket_messages_on_ticket_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_ticket_messages_on_ticket_id ON public.group_ticket_messages USING btree (ticket_id);


--
-- Name: index_group_tickets_on_assignee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_tickets_on_assignee_id ON public.group_tickets USING btree (assignee_id);


--
-- Name: index_group_tickets_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_tickets_on_group_id ON public.group_tickets USING btree (group_id);


--
-- Name: index_group_tickets_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_tickets_on_status ON public.group_tickets USING btree (status);


--
-- Name: index_group_tickets_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_tickets_on_user_id ON public.group_tickets USING btree (user_id);


--
-- Name: index_groups_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_groups_on_category_id ON public.groups USING btree (category_id);


--
-- Name: index_groups_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_groups_on_slug ON public.groups USING btree (slug);


--
-- Name: index_installments_on_franchise_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_installments_on_franchise_id ON public.installments USING btree (franchise_id);


--
-- Name: index_installments_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_installments_on_media_type_and_media_id ON public.installments USING btree (media_type, media_id);


--
-- Name: index_leader_chat_messages_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_leader_chat_messages_on_group_id ON public.leader_chat_messages USING btree (group_id);


--
-- Name: index_leader_chat_messages_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_leader_chat_messages_on_user_id ON public.leader_chat_messages USING btree (user_id);


--
-- Name: index_library_entries_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_entries_on_anime_id ON public.library_entries USING btree (anime_id);


--
-- Name: index_library_entries_on_anime_id_partial; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_entries_on_anime_id_partial ON public.library_entries USING btree (anime_id) WHERE (anime_id IS NOT NULL);


--
-- Name: index_library_entries_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_entries_on_manga_id ON public.library_entries USING btree (manga_id);


--
-- Name: index_library_entries_on_manga_id_partial; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_entries_on_manga_id_partial ON public.library_entries USING btree (manga_id) WHERE (manga_id IS NOT NULL);


--
-- Name: index_library_entries_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_entries_on_user_id ON public.library_entries USING btree (user_id);


--
-- Name: index_library_entries_on_user_id_and_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_library_entries_on_user_id_and_media_type_and_media_id ON public.library_entries USING btree (user_id, media_type, media_id);


--
-- Name: index_library_entries_on_user_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_entries_on_user_id_and_status ON public.library_entries USING btree (user_id, status);


--
-- Name: index_library_entry_logs_on_linked_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_entry_logs_on_linked_account_id ON public.library_entry_logs USING btree (linked_account_id);


--
-- Name: index_library_events_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_events_on_anime_id ON public.library_events USING btree (anime_id) WHERE (anime_id IS NOT NULL);


--
-- Name: index_library_events_on_drama_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_events_on_drama_id ON public.library_events USING btree (drama_id) WHERE (drama_id IS NOT NULL);


--
-- Name: index_library_events_on_library_entry_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_events_on_library_entry_id ON public.library_events USING btree (library_entry_id);


--
-- Name: index_library_events_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_events_on_manga_id ON public.library_events USING btree (manga_id) WHERE (manga_id IS NOT NULL);


--
-- Name: index_library_events_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_library_events_on_user_id ON public.library_events USING btree (user_id);


--
-- Name: index_linked_accounts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_linked_accounts_on_user_id ON public.linked_accounts USING btree (user_id);


--
-- Name: index_manga_characters_on_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_manga_characters_on_character_id ON public.manga_characters USING btree (character_id);


--
-- Name: index_manga_characters_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_manga_characters_on_manga_id ON public.manga_characters USING btree (manga_id);


--
-- Name: index_manga_characters_on_manga_id_and_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_manga_characters_on_manga_id_and_character_id ON public.manga_characters USING btree (manga_id, character_id);


--
-- Name: index_manga_media_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_manga_media_attribute ON public.manga_media_attributes USING btree (manga_id, media_attribute_id);


--
-- Name: index_manga_media_attributes_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_manga_media_attributes_on_manga_id ON public.manga_media_attributes USING btree (manga_id);


--
-- Name: index_manga_media_attributes_on_media_attribute_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_manga_media_attributes_on_media_attribute_id ON public.manga_media_attributes USING btree (media_attribute_id);


--
-- Name: index_manga_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_manga_on_slug ON public.manga USING btree (slug);


--
-- Name: index_manga_staff_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_manga_staff_on_manga_id ON public.manga_staff USING btree (manga_id);


--
-- Name: index_manga_staff_on_manga_id_and_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_manga_staff_on_manga_id_and_person_id ON public.manga_staff USING btree (manga_id, person_id);


--
-- Name: index_manga_staff_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_manga_staff_on_person_id ON public.manga_staff USING btree (person_id);


--
-- Name: index_mappings_on_external_and_item; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_mappings_on_external_and_item ON public.mappings USING btree (external_site, external_id, item_type, item_id);


--
-- Name: index_mappings_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mappings_on_item_type_and_item_id ON public.mappings USING btree (item_type, item_id);


--
-- Name: index_media_attribute_votes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_attribute_votes_on_user_id ON public.media_attribute_votes USING btree (user_id);


--
-- Name: index_media_attributes_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_attributes_on_slug ON public.media_attributes USING btree (slug);


--
-- Name: index_media_attributes_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_attributes_on_title ON public.media_attributes USING btree (title);


--
-- Name: index_media_categories_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_categories_on_category_id ON public.media_categories USING btree (category_id);


--
-- Name: index_media_categories_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_categories_on_media_type_and_media_id ON public.media_categories USING btree (media_type, media_id);


--
-- Name: index_media_characters_on_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_characters_on_character_id ON public.media_characters USING btree (character_id);


--
-- Name: index_media_characters_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_characters_on_media_type_and_media_id ON public.media_characters USING btree (media_type, media_id);


--
-- Name: index_media_ignores_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_ignores_on_media_type_and_media_id ON public.media_ignores USING btree (media_type, media_id);


--
-- Name: index_media_ignores_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_ignores_on_user_id ON public.media_ignores USING btree (user_id);


--
-- Name: index_media_productions_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_productions_on_company_id ON public.media_productions USING btree (company_id);


--
-- Name: index_media_productions_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_productions_on_media_type_and_media_id ON public.media_productions USING btree (media_type, media_id);


--
-- Name: index_media_reaction_votes_on_media_reaction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_reaction_votes_on_media_reaction_id ON public.media_reaction_votes USING btree (media_reaction_id);


--
-- Name: index_media_reaction_votes_on_media_reaction_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_media_reaction_votes_on_media_reaction_id_and_user_id ON public.media_reaction_votes USING btree (media_reaction_id, user_id);


--
-- Name: index_media_reaction_votes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_reaction_votes_on_user_id ON public.media_reaction_votes USING btree (user_id);


--
-- Name: index_media_reactions_on_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_reactions_on_anime_id ON public.media_reactions USING btree (anime_id);


--
-- Name: index_media_reactions_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_reactions_on_deleted_at ON public.media_reactions USING btree (deleted_at);


--
-- Name: index_media_reactions_on_drama_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_reactions_on_drama_id ON public.media_reactions USING btree (drama_id);


--
-- Name: index_media_reactions_on_library_entry_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_reactions_on_library_entry_id ON public.media_reactions USING btree (library_entry_id);


--
-- Name: index_media_reactions_on_manga_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_reactions_on_manga_id ON public.media_reactions USING btree (manga_id);


--
-- Name: index_media_reactions_on_media_type_and_media_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_media_reactions_on_media_type_and_media_id_and_user_id ON public.media_reactions USING btree (media_type, media_id, user_id) WHERE (deleted_at IS NULL);


--
-- Name: index_media_reactions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_reactions_on_user_id ON public.media_reactions USING btree (user_id);


--
-- Name: index_media_relationships_on_source_type_and_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_relationships_on_source_type_and_source_id ON public.media_relationships USING btree (source_type, source_id);


--
-- Name: index_media_staff_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_staff_on_media_type_and_media_id ON public.media_staff USING btree (media_type, media_id);


--
-- Name: index_media_staff_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_media_staff_on_person_id ON public.media_staff USING btree (person_id);


--
-- Name: index_not_interesteds_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_not_interesteds_on_user_id ON public.not_interesteds USING btree (user_id);


--
-- Name: index_notification_settings_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notification_settings_on_user_id ON public.notification_settings USING btree (user_id);


--
-- Name: index_notifications_on_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_source_id ON public.notifications USING btree (source_id);


--
-- Name: index_notifications_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_user_id ON public.notifications USING btree (user_id);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON public.oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON public.oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON public.oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON public.oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_owner_id_and_owner_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_applications_on_owner_id_and_owner_type ON public.oauth_applications USING btree (owner_id, owner_type);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON public.oauth_applications USING btree (uid);


--
-- Name: index_one_signal_players_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_one_signal_players_on_user_id ON public.one_signal_players USING btree (user_id);


--
-- Name: index_partner_codes_on_partner_deal_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_partner_codes_on_partner_deal_id_and_user_id ON public.partner_codes USING btree (partner_deal_id, user_id);


--
-- Name: index_partner_deals_on_valid_countries; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_partner_deals_on_valid_countries ON public.partner_deals USING gin (valid_countries);


--
-- Name: index_people_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_people_on_slug ON public.people USING btree (slug);


--
-- Name: index_post_follows_on_post_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_post_follows_on_post_id ON public.post_follows USING btree (post_id);


--
-- Name: index_post_follows_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_post_follows_on_user_id ON public.post_follows USING btree (user_id);


--
-- Name: index_post_likes_on_post_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_post_likes_on_post_id ON public.post_likes USING btree (post_id);


--
-- Name: index_post_likes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_post_likes_on_user_id ON public.post_likes USING btree (user_id);


--
-- Name: index_posts_on_ao_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_posts_on_ao_id ON public.posts USING btree (ao_id);


--
-- Name: index_posts_on_community_recommendation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_posts_on_community_recommendation_id ON public.posts USING btree (community_recommendation_id);


--
-- Name: index_posts_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_posts_on_deleted_at ON public.posts USING btree (deleted_at);


--
-- Name: index_posts_on_locked_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_posts_on_locked_by_id ON public.posts USING btree (locked_by_id);


--
-- Name: index_pro_subscriptions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pro_subscriptions_on_user_id ON public.pro_subscriptions USING btree (user_id);


--
-- Name: index_profile_links_on_profile_link_site_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_profile_links_on_profile_link_site_id ON public.profile_links USING btree (profile_link_site_id);


--
-- Name: index_profile_links_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_profile_links_on_user_id ON public.profile_links USING btree (user_id);


--
-- Name: index_profile_links_on_user_id_and_profile_link_site_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_profile_links_on_user_id_and_profile_link_site_id ON public.profile_links USING btree (user_id, profile_link_site_id);


--
-- Name: index_quote_likes_on_quote_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quote_likes_on_quote_id ON public.quote_likes USING btree (quote_id);


--
-- Name: index_quote_likes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quote_likes_on_user_id ON public.quote_likes USING btree (user_id);


--
-- Name: index_quote_lines_on_character_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quote_lines_on_character_id ON public.quote_lines USING btree (character_id);


--
-- Name: index_quote_lines_on_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quote_lines_on_order ON public.quote_lines USING btree ("order");


--
-- Name: index_quote_lines_on_quote_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quote_lines_on_quote_id ON public.quote_lines USING btree (quote_id);


--
-- Name: index_quotes_on_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quotes_on_media_id ON public.quotes USING btree (media_id);


--
-- Name: index_quotes_on_media_id_and_media_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quotes_on_media_id_and_media_type ON public.quotes USING btree (media_id, media_type);


--
-- Name: index_recommendations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recommendations_on_user_id ON public.recommendations USING btree (user_id);


--
-- Name: index_reports_on_naughty_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_reports_on_naughty_id_and_user_id ON public.reports USING btree (naughty_id, user_id);


--
-- Name: index_reports_on_naughty_type_and_naughty_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reports_on_naughty_type_and_naughty_id ON public.reports USING btree (naughty_type, naughty_id);


--
-- Name: index_reports_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reports_on_status ON public.reports USING btree (status);


--
-- Name: index_reposts_on_post_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reposts_on_post_id ON public.reposts USING btree (post_id);


--
-- Name: index_reposts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reposts_on_user_id ON public.reposts USING btree (user_id);


--
-- Name: index_review_likes_on_review_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_review_likes_on_review_id ON public.review_likes USING btree (review_id);


--
-- Name: index_review_likes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_review_likes_on_user_id ON public.review_likes USING btree (user_id);


--
-- Name: index_reviews_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_deleted_at ON public.reviews USING btree (deleted_at);


--
-- Name: index_reviews_on_likes_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_likes_count ON public.reviews USING btree (likes_count);


--
-- Name: index_reviews_on_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_media_id ON public.reviews USING btree (media_id);


--
-- Name: index_reviews_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_user_id ON public.reviews USING btree (user_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON public.roles USING btree (name, resource_type, resource_id);


--
-- Name: index_stats_on_type_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_stats_on_type_and_user_id ON public.stats USING btree (type, user_id);


--
-- Name: index_stats_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stats_on_user_id ON public.stats USING btree (user_id);


--
-- Name: index_stories_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stories_on_created_at ON public.stories USING btree (created_at);


--
-- Name: index_stories_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stories_on_deleted_at ON public.stories USING btree (deleted_at);


--
-- Name: index_stories_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stories_on_group_id ON public.stories USING btree (group_id);


--
-- Name: index_stories_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stories_on_user_id ON public.stories USING btree (user_id);


--
-- Name: index_streaming_links_on_media_type_and_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_streaming_links_on_media_type_and_media_id ON public.streaming_links USING btree (media_type, media_id);


--
-- Name: index_streaming_links_on_regions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_streaming_links_on_regions ON public.streaming_links USING gin (regions);


--
-- Name: index_streaming_links_on_streamer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_streaming_links_on_streamer_id ON public.streaming_links USING btree (streamer_id);


--
-- Name: index_uploads_on_owner_type_and_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uploads_on_owner_type_and_owner_id ON public.uploads USING btree (owner_type, owner_id);


--
-- Name: index_uploads_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uploads_on_user_id ON public.uploads USING btree (user_id);


--
-- Name: index_user_ip_addresses_on_ip_address_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_ip_addresses_on_ip_address_and_user_id ON public.user_ip_addresses USING btree (ip_address, user_id);


--
-- Name: index_user_ip_addresses_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_ip_addresses_on_user_id ON public.user_ip_addresses USING btree (user_id);


--
-- Name: index_user_media_on_media_attr_votes; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_media_on_media_attr_votes ON public.media_attribute_votes USING btree (user_id, media_id, media_type);


--
-- Name: index_users_on_ao_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_ao_id ON public.users USING btree (ao_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_facebook_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_facebook_id ON public.users USING btree (facebook_id);


--
-- Name: index_users_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_slug ON public.users USING btree (slug);


--
-- Name: index_users_on_to_follow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_to_follow ON public.users USING btree (to_follow);


--
-- Name: index_users_on_waifu_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_waifu_id ON public.users USING btree (waifu_id);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON public.users_roles USING btree (user_id, role_id);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: index_versions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_user_id ON public.versions USING btree (user_id);


--
-- Name: index_videos_on_dub_lang; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_videos_on_dub_lang ON public.videos USING btree (dub_lang);


--
-- Name: index_videos_on_episode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_videos_on_episode_id ON public.videos USING btree (episode_id);


--
-- Name: index_videos_on_regions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_videos_on_regions ON public.videos USING gin (regions);


--
-- Name: index_videos_on_streamer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_videos_on_streamer_id ON public.videos USING btree (streamer_id);


--
-- Name: index_videos_on_sub_lang; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_videos_on_sub_lang ON public.videos USING btree (sub_lang);


--
-- Name: index_votes_on_target_id_and_target_type_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_votes_on_target_id_and_target_type_and_user_id ON public.votes USING btree (target_id, target_type, user_id);


--
-- Name: index_votes_on_user_id_and_target_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_user_id_and_target_type ON public.votes USING btree (user_id, target_type);


--
-- Name: index_wiki_submission_logs_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_submission_logs_on_user_id ON public.wiki_submission_logs USING btree (user_id);


--
-- Name: index_wiki_submission_logs_on_wiki_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_submission_logs_on_wiki_submission_id ON public.wiki_submission_logs USING btree (wiki_submission_id);


--
-- Name: index_wiki_submission_on_data_id_and_data_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_submission_on_data_id_and_data_type ON public.wiki_submissions USING btree (((data -> 'id'::text)), ((data -> 'type'::text)));


--
-- Name: index_wiki_submissions_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_submissions_on_parent_id ON public.wiki_submissions USING btree (parent_id);


--
-- Name: index_wiki_submissions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_submissions_on_user_id ON public.wiki_submissions USING btree (user_id);


--
-- Name: library_entries_user_id_anime_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX library_entries_user_id_anime_id_idx ON public.library_entries USING btree (user_id, anime_id);


--
-- Name: manga_average_rating_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX manga_average_rating_idx ON public.manga USING btree (average_rating);


--
-- Name: manga_user_count_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX manga_user_count_idx ON public.manga USING btree (user_count);


--
-- Name: posts_media_type_media_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posts_media_type_media_id_idx ON public.posts USING btree (media_type, media_id);


--
-- Name: posts_target_group_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posts_target_group_id_idx ON public.posts USING btree (target_group_id);


--
-- Name: posts_target_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posts_target_user_id_idx ON public.posts USING btree (target_user_id);


--
-- Name: posts_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posts_user_id_idx ON public.posts USING btree (user_id);


--
-- Name: stats_expr_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stats_expr_idx ON public.stats USING btree (((stats_data ->> 'time'::text)));


--
-- Name: users_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_lower_idx ON public.users USING btree (lower((email)::text));


--
-- Name: drama_characters fk_rails_1263ae69d4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_characters
    ADD CONSTRAINT fk_rails_1263ae69d4 FOREIGN KEY (character_id) REFERENCES public.characters(id);


--
-- Name: drama_castings fk_rails_13a6ca2d95; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_castings
    ADD CONSTRAINT fk_rails_13a6ca2d95 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: group_reports fk_rails_13d07d040e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_reports
    ADD CONSTRAINT fk_rails_13d07d040e FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: category_favorites fk_rails_146a35d9c5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_favorites
    ADD CONSTRAINT fk_rails_146a35d9c5 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: profile_links fk_rails_16f7039808; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profile_links
    ADD CONSTRAINT fk_rails_16f7039808 FOREIGN KEY (profile_link_site_id) REFERENCES public.profile_link_sites(id);


--
-- Name: drama_castings fk_rails_25f32514ae; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_castings
    ADD CONSTRAINT fk_rails_25f32514ae FOREIGN KEY (drama_character_id) REFERENCES public.drama_characters(id);


--
-- Name: anime_characters fk_rails_2f1dc82248; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_characters
    ADD CONSTRAINT fk_rails_2f1dc82248 FOREIGN KEY (character_id) REFERENCES public.characters(id);


--
-- Name: dramas_media_attributes fk_rails_2f9d586d2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dramas_media_attributes
    ADD CONSTRAINT fk_rails_2f9d586d2c FOREIGN KEY (media_attribute_id) REFERENCES public.media_attributes(id);


--
-- Name: group_action_logs fk_rails_315397a42e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_action_logs
    ADD CONSTRAINT fk_rails_315397a42e FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: comments fk_rails_31554e7034; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_31554e7034 FOREIGN KEY (parent_id) REFERENCES public.comments(id);


--
-- Name: community_recommendations fk_rails_31cb227f33; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_recommendations
    ADD CONSTRAINT fk_rails_31cb227f33 FOREIGN KEY (community_recommendation_request_id) REFERENCES public.community_recommendation_requests(id);


--
-- Name: group_reports fk_rails_32fa0c6a2d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_reports
    ADD CONSTRAINT fk_rails_32fa0c6a2d FOREIGN KEY (moderator_id) REFERENCES public.users(id);


--
-- Name: dramas_media_attributes fk_rails_396f09ea2e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dramas_media_attributes
    ADD CONSTRAINT fk_rails_396f09ea2e FOREIGN KEY (drama_id) REFERENCES public.dramas(id);


--
-- Name: drama_staff fk_rails_3b6a65697e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_staff
    ADD CONSTRAINT fk_rails_3b6a65697e FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: posts fk_rails_43023491e6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_rails_43023491e6 FOREIGN KEY (target_user_id) REFERENCES public.users(id);


--
-- Name: group_action_logs fk_rails_45954c6dcd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_action_logs
    ADD CONSTRAINT fk_rails_45954c6dcd FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: group_tickets fk_rails_491e1dcdd8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_tickets
    ADD CONSTRAINT fk_rails_491e1dcdd8 FOREIGN KEY (assignee_id) REFERENCES public.users(id);


--
-- Name: ama_subscribers fk_rails_4ac07cb7f6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ama_subscribers
    ADD CONSTRAINT fk_rails_4ac07cb7f6 FOREIGN KEY (ama_id) REFERENCES public.amas(id);


--
-- Name: group_tickets fk_rails_58b133f20c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_tickets
    ADD CONSTRAINT fk_rails_58b133f20c FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: anime_castings fk_rails_5f90e1a017; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_castings
    ADD CONSTRAINT fk_rails_5f90e1a017 FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: group_invites fk_rails_62774fb6d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_invites
    ADD CONSTRAINT fk_rails_62774fb6d2 FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: leader_chat_messages fk_rails_638f2b72ee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leader_chat_messages
    ADD CONSTRAINT fk_rails_638f2b72ee FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: manga_characters fk_rails_6483521d5a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_characters
    ADD CONSTRAINT fk_rails_6483521d5a FOREIGN KEY (character_id) REFERENCES public.characters(id);


--
-- Name: manga_staff fk_rails_6e98078d9d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_staff
    ADD CONSTRAINT fk_rails_6e98078d9d FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: group_invites fk_rails_7255dc4343; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_invites
    ADD CONSTRAINT fk_rails_7255dc4343 FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: site_announcements fk_rails_725ca0b80c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_announcements
    ADD CONSTRAINT fk_rails_725ca0b80c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: community_recommendation_follows fk_rails_798884902b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_recommendation_follows
    ADD CONSTRAINT fk_rails_798884902b FOREIGN KEY (community_recommendation_request_id) REFERENCES public.community_recommendation_requests(id);


--
-- Name: group_bans fk_rails_7dd1d13ab5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_bans
    ADD CONSTRAINT fk_rails_7dd1d13ab5 FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: anime_media_attributes fk_rails_88955ab592; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_media_attributes
    ADD CONSTRAINT fk_rails_88955ab592 FOREIGN KEY (media_attribute_id) REFERENCES public.media_attributes(id);


--
-- Name: groups fk_rails_a61500b09c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_rails_a61500b09c FOREIGN KEY (category_id) REFERENCES public.group_categories(id);


--
-- Name: library_entries fk_rails_a7e4cb3aba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_entries
    ADD CONSTRAINT fk_rails_a7e4cb3aba FOREIGN KEY (media_reaction_id) REFERENCES public.media_reactions(id);


--
-- Name: wiki_submissions fk_rails_a999a0edd3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_submissions
    ADD CONSTRAINT fk_rails_a999a0edd3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: anime_castings fk_rails_ad010645ce; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_castings
    ADD CONSTRAINT fk_rails_ad010645ce FOREIGN KEY (anime_character_id) REFERENCES public.anime_characters(id);


--
-- Name: groups fk_rails_ae0dbbc874; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_rails_ae0dbbc874 FOREIGN KEY (pinned_post_id) REFERENCES public.posts(id);


--
-- Name: drama_castings fk_rails_aef2c89cbe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drama_castings
    ADD CONSTRAINT fk_rails_aef2c89cbe FOREIGN KEY (licensor_id) REFERENCES public.producers(id);


--
-- Name: post_follows fk_rails_afb3620fdd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_follows
    ADD CONSTRAINT fk_rails_afb3620fdd FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: group_member_notes fk_rails_b689eab49d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_member_notes
    ADD CONSTRAINT fk_rails_b689eab49d FOREIGN KEY (group_member_id) REFERENCES public.group_members(id);


--
-- Name: users fk_rails_bc615464bf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_bc615464bf FOREIGN KEY (pinned_post_id) REFERENCES public.posts(id);


--
-- Name: group_bans fk_rails_bf82b17bd6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_bans
    ADD CONSTRAINT fk_rails_bf82b17bd6 FOREIGN KEY (moderator_id) REFERENCES public.users(id);


--
-- Name: wiki_submission_logs fk_rails_bfb160bb8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_submission_logs
    ADD CONSTRAINT fk_rails_bfb160bb8d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: comment_likes fk_rails_c28a479c60; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT fk_rails_c28a479c60 FOREIGN KEY (comment_id) REFERENCES public.comments(id);


--
-- Name: wiki_submission_logs fk_rails_c2dc8d2821; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_submission_logs
    ADD CONSTRAINT fk_rails_c2dc8d2821 FOREIGN KEY (wiki_submission_id) REFERENCES public.wiki_submissions(id);


--
-- Name: reposts fk_rails_c395f67885; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reposts
    ADD CONSTRAINT fk_rails_c395f67885 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: anime_castings fk_rails_c724c451cd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_castings
    ADD CONSTRAINT fk_rails_c724c451cd FOREIGN KEY (licensor_id) REFERENCES public.producers(id);


--
-- Name: blocks fk_rails_c7fbc30382; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT fk_rails_c7fbc30382 FOREIGN KEY (blocked_id) REFERENCES public.users(id);


--
-- Name: anime_staff fk_rails_cdd9599b2a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime_staff
    ADD CONSTRAINT fk_rails_cdd9599b2a FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: reports fk_rails_cfe003e081; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_rails_cfe003e081 FOREIGN KEY (moderator_id) REFERENCES public.users(id);


--
-- Name: media_reaction_votes fk_rails_dab3468b92; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_reaction_votes
    ADD CONSTRAINT fk_rails_dab3468b92 FOREIGN KEY (media_reaction_id) REFERENCES public.media_reactions(id);


--
-- Name: group_ticket_messages fk_rails_e77fcefb97; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_ticket_messages
    ADD CONSTRAINT fk_rails_e77fcefb97 FOREIGN KEY (ticket_id) REFERENCES public.group_tickets(id);


--
-- Name: category_favorites fk_rails_e879bc7c3b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_favorites
    ADD CONSTRAINT fk_rails_e879bc7c3b FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: manga_media_attributes fk_rails_e94250c6cb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manga_media_attributes
    ADD CONSTRAINT fk_rails_e94250c6cb FOREIGN KEY (media_attribute_id) REFERENCES public.media_attributes(id);


--
-- Name: reposts fk_rails_e9f75e0f73; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reposts
    ADD CONSTRAINT fk_rails_e9f75e0f73 FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: amas fk_rails_ef2f48b4b8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amas
    ADD CONSTRAINT fk_rails_ef2f48b4b8 FOREIGN KEY (original_post_id) REFERENCES public.posts(id);


--
-- Name: group_tickets fk_rails_f2a96e30ec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_tickets
    ADD CONSTRAINT fk_rails_f2a96e30ec FOREIGN KEY (first_message_id) REFERENCES public.group_ticket_messages(id);


--
-- Name: group_permissions fk_rails_f60693a634; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_permissions
    ADD CONSTRAINT fk_rails_f60693a634 FOREIGN KEY (group_member_id) REFERENCES public.group_members(id);


--
-- Name: group_neighbors fk_rails_f61dff96a9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_neighbors
    ADD CONSTRAINT fk_rails_f61dff96a9 FOREIGN KEY (destination_id) REFERENCES public.groups(id);


--
-- Name: posts fk_rails_f82460b586; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_rails_f82460b586 FOREIGN KEY (community_recommendation_id) REFERENCES public.community_recommendations(id);


--
-- Name: streaming_links fk_rails_f92451e4ed; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streaming_links
    ADD CONSTRAINT fk_rails_f92451e4ed FOREIGN KEY (streamer_id) REFERENCES public.streamers(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20150924063228'),
('20150926085842'),
('20150927002118'),
('20151001030141'),
('20151002044617'),
('20151003032710'),
('20151003085835'),
('20151003233701'),
('20151006060753'),
('20151007055934'),
('20151130032929'),
('20151130063746'),
('20151130074941'),
('20151130083322'),
('20151211081155'),
('20151213075316'),
('20151213085908'),
('20151213100401'),
('20151223065939'),
('20160109045957'),
('20160417064936'),
('20160527090120'),
('20160629073541'),
('20160702083448'),
('20160705041049'),
('20161003165019'),
('20161003225612'),
('20161010200413'),
('20161012204844'),
('20161013173818'),
('20161019003515'),
('20161019004726'),
('20161026215344'),
('20161026224944'),
('20161028075454'),
('20161029060323'),
('20161101203815'),
('20161102183115'),
('20161102232654'),
('20161107224046'),
('20161108024127'),
('20161110055102'),
('20161110060801'),
('20161110234659'),
('20161112011840'),
('20161114042030'),
('20161115070551'),
('20161115181856'),
('20161116064623'),
('20161118180235'),
('20161119003642'),
('20161123015147'),
('20161124003538'),
('20161124021947'),
('20161124040820'),
('20161124051242'),
('20161125232508'),
('20161129050639'),
('20161129192003'),
('20161130210427'),
('20161202203815'),
('20161203192738'),
('20161204092247'),
('20161205014148'),
('20161207194453'),
('20161208090624'),
('20161213122246'),
('20161214055929'),
('20161214200735'),
('20161214201646'),
('20161215204926'),
('20161216124624'),
('20161219013436'),
('20161220092016'),
('20161221100140'),
('20161226194618'),
('20161229130815'),
('20170104002112'),
('20170107034610'),
('20170108051834'),
('20170108054725'),
('20170111185104'),
('20170115234206'),
('20170116051758'),
('20170116102736'),
('20170117004835'),
('20170117232818'),
('20170118222403'),
('20170122224414'),
('20170125231710'),
('20170201230414'),
('20170204005149'),
('20170210211932'),
('20170211082904'),
('20170213214437'),
('20170214075641'),
('20170215210450'),
('20170215211048'),
('20170215225213'),
('20170224041615'),
('20170224050925'),
('20170224234712'),
('20170226192407'),
('20170302012154'),
('20170302181054'),
('20170302192915'),
('20170302195631'),
('20170302234018'),
('20170304203731'),
('20170305071424'),
('20170306055742'),
('20170307020211'),
('20170307022155'),
('20170307023205'),
('20170308043418'),
('20170308064349'),
('20170308231654'),
('20170309124949'),
('20170311003803'),
('20170311043220'),
('20170316091525'),
('20170317204638'),
('20170318210412'),
('20170318213404'),
('20170318220421'),
('20170318224640'),
('20170319021941'),
('20170319034357'),
('20170319040245'),
('20170319071813'),
('20170325205929'),
('20170326222205'),
('20170329203624'),
('20170410193746'),
('20170414035343'),
('20170417224628'),
('20170418003511'),
('20170420035108'),
('20170426093647'),
('20170426123432'),
('20170429034030'),
('20170430050223'),
('20170501234913'),
('20170502061636'),
('20170507033440'),
('20170507190201'),
('20170511062519'),
('20170512042542'),
('20170512042843'),
('20170512081514'),
('20170515122347'),
('20170518220741'),
('20170529105358'),
('20170529105808'),
('20170531082123'),
('20170601084705'),
('20170601214239'),
('20170602033751'),
('20170602065530'),
('20170602065925'),
('20170607055017'),
('20170614063228'),
('20170614070503'),
('20170615000439'),
('20170616053125'),
('20170620005334'),
('20170629184039'),
('20170702234704'),
('20170705052357'),
('20170705053245'),
('20170710021937'),
('20170715053459'),
('20170715055251'),
('20170715212950'),
('20170716054623'),
('20170717043528'),
('20170719070649'),
('20170721020210'),
('20170721021615'),
('20170721022437'),
('20170723045121'),
('20170723224959'),
('20170724000734'),
('20170724025320'),
('20170724025426'),
('20170724030114'),
('20170724070041'),
('20170725220827'),
('20170726071033'),
('20170726221601'),
('20170726230852'),
('20170726230941'),
('20170728231231'),
('20170728231327'),
('20170728234324'),
('20170729034131'),
('20170729034302'),
('20170729205855'),
('20170729210024'),
('20170802083750'),
('20170807084811'),
('20170812072909'),
('20170817101151'),
('20170818204827'),
('20170819034722'),
('20170819034850'),
('20170819055109'),
('20170822072811'),
('20170828080526'),
('20170829045027'),
('20170829213002'),
('20170902160628'),
('20170904052311'),
('20170905231125'),
('20170909082819'),
('20170919034156'),
('20171013043506'),
('20171017003438'),
('20171023210622'),
('20171025222450'),
('20171026012230'),
('20171215020034'),
('20171231030819'),
('20171231032518'),
('20180110055601'),
('20180114070606'),
('20180116051449'),
('20180206225558'),
('20180228020228'),
('20180314015934'),
('20180319230733'),
('20180329211224'),
('20180329215148'),
('20180504045902'),
('20180524205232'),
('20180606201703'),
('20180606202637'),
('20180608215546'),
('20180609011947'),
('20180620010855'),
('20180620011012'),
('20180620015707'),
('20180719012821'),
('20180720231815'),
('20180722222944'),
('20180724022853'),
('20180810153156'),
('20180810220654'),
('20180823024854'),
('20180831220322'),
('20180831221128'),
('20180921200713'),
('20181010215125'),
('20181023222601'),
('20181023224914'),
('20181024211956'),
('20181025194801'),
('20181105191746'),
('20181105200940'),
('20181115034027'),
('20181125234910'),
('20181128040156'),
('20181215004955'),
('20181225023100'),
('20190103054632'),
('20190207011112'),
('20190211222650'),
('20190211224502'),
('20190217050321'),
('20190221013130'),
('20190223050111'),
('20190603133124'),
('20200418043417'),
('20200603235008'),
('20200730022608'),
('20200730023943'),
('20200802164318'),
('20200803004935'),
('20200809034239'),
('20200809034626'),
('20200809034845'),
('20200809221150'),
('20200812034201'),
('20200822214657'),
('20201030020815'),
('20201126190937'),
('20201206202624'),
('20210126044815'),
('20210403025623'),
('20210405030335'),
('20210406023328'),
('20210410224334'),
('20210427225015'),
('20210427230857'),
('20210506021756'),
('20210522191237'),
('20210605015255'),
('20210605031927'),
('20210613042826'),
('20210914002937'),
('20210914024137'),
('20210916050650'),
('20210917003018'),
('20210917023903'),
('20210917063653'),
('20210917064233'),
('20210919020317'),
('20210919033244'),
('20210919215315'),
('20210919222140'),
('20210921231835'),
('20211001221303'),
('20211001223509'),
('20211002175842'),
('20211002180702'),
('20211002202720'),
('20211014051130'),
('20211115070151'),
('20211115073159'),
('20220503045222'),
('20220613032400'),
('20220613043858');


