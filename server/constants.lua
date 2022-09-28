local Constants = {
    GET_USERID = 'SELECT userid, permissions FROM users WHERE identifier = ?',
    CREATE_USER = "INSERT INTO users(username, identifier) VALUES(?, ?)",
    GET_CHARACTERS = "SELECT charid, firstname, lastname, dateofbirth, skin, job, sex FROM characters WHERE userid = ?",
    GET_CHARACTER = "SELECT * FROM characters WHERE charid = ?",
    CREATE_CHARACTER = "INSERT INTO characters(userid, firstname, lastname, sex, status, skin, coords, job, job_grade) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",
    CREATE_OUTFIT = "INSERT INTO characters_outfits(charid, outfitname, components, active) VALUES(?, ?, ?, ?)",
    GET_ACTIVEOUTFIT = "SELECT * FROM characters_outfits WHERE charid = ? AND active = ?",
    GET_WHITELIST = "SELECT * FROM whitelist WHERE identifier = ?",
}

return Constants
