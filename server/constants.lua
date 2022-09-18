Constants = {
    GET_USERID = ('SELECT userid FROM users WHERE identifier = ?'),
    CREATE_USER = "INSERT INTO users(username, identifier) VALUES(?, ?)",
    GET_CHARACTERS = "SELECT * FROM characters WHERE userid = ?",
    CREATE_CHARACTER = "INSERT INTO characters(userid, firstname, lastname, sex, status, skin)",
    CREATE_OUTFIT = "INSERT INTO characters_outfits(charid, outfitname, components, active) VALUES(?, ?, ?, ?)",
    GET_ACTIVEOUTFIT = "SELECT * FROM characters_outfits WHERE charid = ? AND active = ?",
    GET_WHITELIST = "SELECT * FROM whitelist WHERE identifier = ?"
}
