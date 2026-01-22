-- ---------------------------------------------------------------------
-- Archivo SQL original obtenido de Supabase:
-- https://github.com/supabase/supabase/tree/master/docker/volumes
-- 
-- Copyright 2024 Supabase
-- Licensed under the Apache License, Version 2.0 (the "License");
-- You may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- ---------------------------------------------------------------------

-- Actualización propia, tomamos la BD que definimos nosotros, no
--  postgres que sería la por defecto en caso de no definirla.

\set jwt_secret `echo "$JWT_SECRET"`
\set jwt_exp `echo "$JWT_EXP"`
\set target_db `echo "$POSTGRES_DB"`

ALTER DATABASE :target_db SET "app.settings.jwt_secret" TO :'jwt_secret';
ALTER DATABASE :target_db SET "app.settings.jwt_exp" TO :'jwt_exp';
