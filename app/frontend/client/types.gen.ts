// This file is auto-generated by @hey-api/openapi-ts

export type post = {
    id: string;
    content: string;
    user: {
        id: string;
        email: string;
    };
    visibility: 'everyone' | 'friends_only' | 'nobody';
    created_at: string;
    parent?: (string) | null;
    comments_count: number;
    comments?: Array<comment>;
    model?: string;
};

export type visibility = 'everyone' | 'friends_only' | 'nobody';

export type comment = {
    id: string;
    content: string;
    user: {
        id: string;
        email: string;
    };
    visibility: 'everyone' | 'friends_only' | 'nobody';
    created_at: string;
    parent?: (string) | null;
    comments_count: number;
    comments?: Array<comment>;
    model?: string;
};

export type GetUsersDashboardPostsResponse = ({
    model: Array<post>;
    server_time: string;
});

export type GetUsersDashboardPostsError = (unknown);

export type PostUsersDashboardPostsData = {
    body?: {
        post?: {
            content?: string;
            visibility?: 'everyone' | 'friends_only' | 'nobody';
        };
    };
};

export type PostUsersDashboardPostsResponse = ({
    model: post;
    server_time: string;
});

export type PostUsersDashboardPostsError = (unknown | {
    errors?: {
        Content?: string;
        Visibility?: string;
    };
    server_time?: string;
});

export type GetUsersDashboardPostsByIdData = {
    path: {
        id: string;
    };
};

export type GetUsersDashboardPostsByIdResponse = ({
    model?: post;
    server_time: string;
});

export type GetUsersDashboardPostsByIdError = (unknown);

export type PutUsersDashboardPostsByIdData = {
    body?: {
        post?: {
            content?: string;
            visibility?: 'everyone' | 'friends_only' | 'nobody';
        };
    };
    path: {
        id: string;
    };
};

export type PutUsersDashboardPostsByIdResponse = ({
    model: post;
    server_time: string;
});

export type PutUsersDashboardPostsByIdError = (unknown | {
    errors?: {
        Content?: string;
        Visibility?: string;
    };
    server_time?: string;
});

export type DeleteUsersDashboardPostsByIdData = {
    path: {
        id: string;
    };
};

export type DeleteUsersDashboardPostsByIdResponse = ({
    model: post;
    server_time: string;
});

export type DeleteUsersDashboardPostsByIdError = (unknown);

export type GetUsersDashboardFriendsResponse = ({
    model: {
        followers: Array<{
            id: string;
            user: {
                id: string;
                email: string;
            };
            confirmed: boolean;
        }>;
        following: Array<{
            id: string;
            user: {
                id: string;
                email: string;
            };
            confirmed: boolean;
        }>;
        model: string;
    };
    server_time: string;
});

export type GetUsersDashboardFriendsError = (unknown);

export type PostUsersDashboardFriendsData = {
    body?: {
        other_user_id?: string;
    };
};

export type PostUsersDashboardFriendsResponse = ({
    model: {
        id: string;
        user: {
            id: string;
            email: string;
        };
        confirmed: boolean;
        model: string;
    };
    server_time: string;
});

export type PostUsersDashboardFriendsError = (unknown | {
    errors?: {
        User?: (string) | null;
        Friend?: (string) | null;
    };
    server_time: string;
});

export type PutUsersDashboardFriendsByIdData = {
    path: {
        id: string;
    };
};

export type PutUsersDashboardFriendsByIdResponse = ({
    model: {
        id: string;
        user: {
            id: string;
            email: string;
        };
        confirmed: boolean;
        model: string;
    };
    server_time: string;
});

export type PutUsersDashboardFriendsByIdError = (unknown | {
    errors?: {
        Id?: (string) | null;
    };
    server_time: string;
});

export type DeleteUsersDashboardFriendsByIdData = {
    path: {
        id: string;
    };
};

export type DeleteUsersDashboardFriendsByIdResponse = ({
    model: {
        id: string;
        user: {
            id: string;
            email: string;
        };
        confirmed: boolean;
        model: string;
    };
    server_time: string;
});

export type DeleteUsersDashboardFriendsByIdError = (unknown | {
    errors?: {
        Id?: (string) | null;
    };
    server_time: string;
});

export type PostUsersDashboardFriendsSearchData = {
    body?: {
        query: string;
    };
};

export type PostUsersDashboardFriendsSearchResponse = ({
    model: Array<{
        id: string;
        email: string;
        model?: string;
    }>;
    server_time: string;
});

export type PostUsersDashboardFriendsSearchError = (unknown);